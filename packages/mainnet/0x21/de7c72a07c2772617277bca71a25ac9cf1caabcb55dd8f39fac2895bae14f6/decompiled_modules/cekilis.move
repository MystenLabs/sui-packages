module 0x21de7c72a07c2772617277bca71a25ac9cf1caabcb55dd8f39fac2895bae14f6::cekilis {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Cekilis has key {
        id: 0x2::object::UID,
        ad: 0x1::string::String,
        kaynak: 0x1::string::String,
        handles: vector<0x1::string::String>,
        liste_sha256: vector<u8>,
        kazanan_sayisi: u64,
        kazananlar: vector<u64>,
        cekildi: bool,
    }

    struct CekilisOlusturuldu has copy, drop {
        cekilis_id: 0x2::object::ID,
        ad: 0x1::string::String,
        katilimci: u64,
        kazanan_sayisi: u64,
        liste_sha256: vector<u8>,
    }

    struct Kazanan has copy, drop {
        cekilis_id: 0x2::object::ID,
        sira: u64,
        numara: u64,
        handle: 0x1::string::String,
    }

    struct KuraCekildi has copy, drop {
        cekilis_id: 0x2::object::ID,
        numaralar: vector<u64>,
        handles: vector<0x1::string::String>,
    }

    entry fun cek(arg0: &AdminCap, arg1: &mut Cekilis, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.cekildi, 3);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1.handles);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<u64>(&mut v2, v3 + 1);
            v3 = v3 + 1;
        };
        let v4 = 0x2::object::id<Cekilis>(arg1);
        let v5 = vector[];
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < arg1.kazanan_sayisi) {
            0x1::vector::swap<u64>(&mut v2, v7, 0x2::random::generate_u64_in_range(&mut v0, v7, v1 - 1));
            let v8 = *0x1::vector::borrow<u64>(&v2, v7);
            let v9 = *0x1::vector::borrow<0x1::string::String>(&arg1.handles, v8 - 1);
            let v10 = Kazanan{
                cekilis_id : v4,
                sira       : v7 + 1,
                numara     : v8,
                handle     : v9,
            };
            0x2::event::emit<Kazanan>(v10);
            0x1::vector::push_back<u64>(&mut v5, v8);
            0x1::vector::push_back<0x1::string::String>(&mut v6, v9);
            v7 = v7 + 1;
        };
        arg1.kazananlar = v5;
        arg1.cekildi = true;
        let v11 = KuraCekildi{
            cekilis_id : v4,
            numaralar  : v5,
            handles    : v6,
        };
        0x2::event::emit<KuraCekildi>(v11);
    }

    public fun cekildi(arg0: &Cekilis) : bool {
        arg0.cekildi
    }

    fun gecerli_handle(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 15) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = if (v2 >= 48 && v2 <= 57) {
                true
            } else if (v2 >= 65 && v2 <= 90) {
                true
            } else if (v2 >= 97 && v2 <= 122) {
                true
            } else {
                v2 == 95
            };
            if (!v3) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun handles(arg0: &Cekilis) : &vector<0x1::string::String> {
        &arg0.handles
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun kazananlar(arg0: &Cekilis) : &vector<u64> {
        &arg0.kazananlar
    }

    public fun liste_sha256(arg0: &Cekilis) : &vector<u8> {
        &arg0.liste_sha256
    }

    public fun olustur(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(v0 > 0, 0);
        assert!(arg4 > 0 && arg4 <= v0, 1);
        let v1 = b"";
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(&arg3, v2));
            assert!(gecerli_handle(v3), 2);
            0x1::vector::append<u8>(&mut v1, *v3);
            0x1::vector::push_back<u8>(&mut v1, 10);
            v2 = v2 + 1;
        };
        let v4 = 0x1::hash::sha2_256(v1);
        let v5 = Cekilis{
            id             : 0x2::object::new(arg5),
            ad             : arg1,
            kaynak         : arg2,
            handles        : arg3,
            liste_sha256   : v4,
            kazanan_sayisi : arg4,
            kazananlar     : vector[],
            cekildi        : false,
        };
        let v6 = CekilisOlusturuldu{
            cekilis_id     : 0x2::object::id<Cekilis>(&v5),
            ad             : v5.ad,
            katilimci      : v0,
            kazanan_sayisi : arg4,
            liste_sha256   : v4,
        };
        0x2::event::emit<CekilisOlusturuldu>(v6);
        0x2::transfer::share_object<Cekilis>(v5);
    }

    // decompiled from Move bytecode v7
}

