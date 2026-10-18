module 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa {
    struct Kasa<phantom T0> has key {
        id: 0x2::object::UID,
        domain: u32,
        ihaleler: 0x2::table::Table<u64, Ihale>,
        ihale_sayisi: u64,
        giden: 0x2::table::Table<u64, Giden<T0>>,
        giden_sayisi: u64,
        havuz: 0x2::balance::Balance<T0>,
        emirler: 0x2::table::Table<u64, Emir>,
        emir_sayisi: u64,
    }

    struct Emir has drop, store {
        tur: u8,
        launch: u64,
        varlik: address,
        dolar: u64,
        ref: u64,
        miktar: u64,
        arz: u64,
        ilk: bool,
        hedef_zincir: u32,
        alici: address,
        yapildi: bool,
    }

    struct Ihale has drop, store {
        tur: u8,
        launch: u64,
        varlik: 0x1::type_name::TypeName,
        verilen: u64,
        baslangic: u64,
        baslama: u64,
        hedef_zincir: u32,
        alici: address,
        bitti: bool,
    }

    struct Giden<phantom T0> has store {
        zincir: u32,
        alici: address,
        para: 0x2::balance::Balance<T0>,
    }

    struct DolarKey has copy, drop, store {
        launch: u64,
    }

    struct TaahhutKey has copy, drop, store {
        launch: u64,
    }

    struct VarlikKey has copy, drop, store {
        launch: u64,
        varlik: 0x1::type_name::TypeName,
    }

    struct FiyatKey has copy, drop, store {
        varlik: 0x1::type_name::TypeName,
    }

    struct Fiyat has drop, store {
        dolar: u64,
        varlik: u64,
    }

    struct EmanetKey has copy, drop, store {
        ihale: u64,
    }

    struct Ilan has copy, drop {
        id: u64,
        tur: u8,
        launch: u64,
        varlik: 0x1::type_name::TypeName,
        verilen: u64,
        baslangic: u64,
    }

    struct Doldu has copy, drop {
        id: u64,
        dolduran: address,
        verilen: u64,
        alinan: u64,
    }

    struct Odendi has copy, drop {
        zincir: u32,
        alici: address,
        miktar: u64,
        giden: bool,
    }

    public(friend) fun al_emri<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = dolar_mut<T0>(arg0, arg1);
        0x2::balance::join<T0>(v1, arg2);
        let v2 = taahhut<T0>(arg0, arg1) + v0;
        taahhut_yaz<T0>(arg0, arg1, v2);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let (v4, v5) = son_fiyat<T0>(arg0, v3);
        let v6 = if (v4 > 0) {
            oran(v0, v5, v4)
        } else {
            arg3
        };
        let v7 = v6;
        if (v6 == 0) {
            v7 = 1;
        };
        ilan<T0>(arg0, 1, arg1, v3, v0, v7 * 2, 0, @0x0, arg4);
    }

    public fun bakiye<T0, T1>(arg0: &Kasa<T0>, arg1: u64) : u64 {
        let v0 = VarlikKey{
            launch : arg1,
            varlik : 0x1::type_name::with_defining_ids<T1>(),
        };
        if (0x2::dynamic_field::exists<VarlikKey>(&arg0.id, v0)) {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<VarlikKey, 0x2::balance::Balance<T1>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun dolar_bakiye<T0>(arg0: &Kasa<T0>, arg1: u64) : u64 {
        let v0 = DolarKey{launch: arg1};
        if (0x2::dynamic_field::exists<DolarKey>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<DolarKey, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun dolar_mut<T0>(arg0: &mut Kasa<T0>, arg1: u64) : &mut 0x2::balance::Balance<T0> {
        let v0 = DolarKey{launch: arg1};
        if (!0x2::dynamic_field::exists<DolarKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<DolarKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<DolarKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun doldur_alim<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = istenen<T0>(arg0, arg1, arg3);
        let v1 = 0x2::table::borrow<u64, Ihale>(&arg0.ihaleler, arg1);
        assert!(!v1.bitti, 1);
        assert!(v1.tur == 1, 6);
        assert!(v1.varlik == 0x1::type_name::with_defining_ids<T1>(), 5);
        let v2 = v1.launch;
        let v3 = v1.verilen;
        let v4 = taahhut<T0>(arg0, v2);
        let v5 = oran(v3, dolar_bakiye<T0>(arg0, v2), v4);
        taahhut_yaz<T0>(arg0, v2, v4 - v3);
        assert!(v5 > 0, 4);
        let v6 = 0x2::coin::value<T1>(&arg2);
        assert!(v6 > 0 && v6 >= oran(v0, v5, v3), 2);
        0x2::table::borrow_mut<u64, Ihale>(&mut arg0.ihaleler, arg1).bitti = true;
        let v7 = varlik_mut<T0, T1>(arg0, v2);
        0x2::balance::join<T1>(v7, 0x2::coin::into_balance<T1>(arg2));
        fiyat_yaz<T0>(arg0, 0x1::type_name::with_defining_ids<T1>(), v5, v6);
        let v8 = Doldu{
            id       : arg1,
            dolduran : 0x2::tx_context::sender(arg4),
            verilen  : v5,
            alinan   : v6,
        };
        0x2::event::emit<Doldu>(v8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(dolar_mut<T0>(arg0, v2), v5), arg4)
    }

    public fun doldur_satim<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::table::borrow<u64, Ihale>(&arg0.ihaleler, arg1);
        assert!(!v0.bitti, 1);
        assert!(v0.tur == 2, 6);
        assert!(v0.varlik == 0x1::type_name::with_defining_ids<T1>(), 5);
        let v1 = v0.verilen;
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0 && v2 >= istenen<T0>(arg0, arg1, arg3), 2);
        0x2::table::borrow_mut<u64, Ihale>(&mut arg0.ihaleler, arg1).bitti = true;
        fiyat_yaz<T0>(arg0, 0x1::type_name::with_defining_ids<T1>(), v2, v1);
        let v3 = Doldu{
            id       : arg1,
            dolduran : 0x2::tx_context::sender(arg4),
            verilen  : v1,
            alinan   : v2,
        };
        0x2::event::emit<Doldu>(v3);
        ode<T0>(arg0, v0.hedef_zincir, v0.alici, 0x2::coin::into_balance<T0>(arg2), arg4);
        let v4 = EmanetKey{ihale: arg1};
        0x2::coin::from_balance<T1>(0x2::dynamic_field::remove<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v4), arg4)
    }

    public(friend) fun emir_kaydet<T0>(arg0: &mut Kasa<T0>, arg1: u8, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u32, arg10: address) {
        let v0 = arg0.emir_sayisi;
        let v1 = Emir{
            tur          : arg1,
            launch       : arg2,
            varlik       : arg3,
            dolar        : arg4,
            ref          : arg5,
            miktar       : arg6,
            arz          : arg7,
            ilk          : arg8,
            hedef_zincir : arg9,
            alici        : arg10,
            yapildi      : false,
        };
        0x2::table::add<u64, Emir>(&mut arg0.emirler, v0, v1);
        arg0.emir_sayisi = v0 + 1;
    }

    public fun emir_sayisi<T0>(arg0: &Kasa<T0>) : u64 {
        arg0.emir_sayisi
    }

    fun fiyat_yaz<T0>(arg0: &mut Kasa<T0>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = FiyatKey{varlik: arg1};
        if (0x2::dynamic_field::exists<FiyatKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<FiyatKey, Fiyat>(&mut arg0.id, v0);
            v1.dolar = arg2;
            v1.varlik = arg3;
        } else {
            let v2 = Fiyat{
                dolar  : arg2,
                varlik : arg3,
            };
            0x2::dynamic_field::add<FiyatKey, Fiyat>(&mut arg0.id, v0, v2);
        };
    }

    public fun giden_sayisi<T0>(arg0: &Kasa<T0>) : u64 {
        arg0.giden_sayisi
    }

    public(friend) fun gideni_al<T0>(arg0: &mut Kasa<T0>, arg1: u64) : (u32, address, 0x2::balance::Balance<T0>) {
        let Giden {
            zincir : v0,
            alici  : v1,
            para   : v2,
        } = 0x2::table::remove<u64, Giden<T0>>(&mut arg0.giden, arg1);
        (v0, v1, v2)
    }

    public fun havuz<T0>(arg0: &Kasa<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.havuz)
    }

    public fun ihale_sayisi<T0>(arg0: &Kasa<T0>) : u64 {
        arg0.ihale_sayisi
    }

    fun ilan<T0>(arg0: &mut Kasa<T0>, arg1: u8, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u32, arg7: address, arg8: &0x2::clock::Clock) {
        let v0 = arg0.ihale_sayisi;
        let v1 = Ihale{
            tur          : arg1,
            launch       : arg2,
            varlik       : arg3,
            verilen      : arg4,
            baslangic    : arg5,
            baslama      : 0x2::clock::timestamp_ms(arg8),
            hedef_zincir : arg6,
            alici        : arg7,
            bitti        : false,
        };
        0x2::table::add<u64, Ihale>(&mut arg0.ihaleler, v0, v1);
        arg0.ihale_sayisi = v0 + 1;
        let v2 = Ilan{
            id        : v0,
            tur       : arg1,
            launch    : arg2,
            varlik    : arg3,
            verilen   : arg4,
            baslangic : arg5,
        };
        0x2::event::emit<Ilan>(v2);
    }

    public fun istenen<T0>(arg0: &Kasa<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<u64, Ihale>(&arg0.ihaleler, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2) - v0.baslama;
        let v2 = v1 / 1800000;
        let v3 = v0.baslangic / 16;
        if (v2 >= 64) {
            return v3
        };
        let v4 = v0.baslangic >> (v2 as u8);
        let v5 = v4 - oran(v4, v1 % 1800000, 2 * 1800000);
        if (v5 > v3) {
            v5
        } else {
            v3
        }
    }

    public fun kabul<T0>(arg0: &mut Kasa<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x2::balance::join<T0>(&mut arg0.havuz, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
    }

    public fun kimlik<T0>(arg0: &Kasa<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun ode<T0>(arg0: &mut Kasa<T0>, arg1: u32, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == arg0.domain) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg4), arg2);
            let v0 = Odendi{
                zincir : arg1,
                alici  : arg2,
                miktar : 0x2::balance::value<T0>(&arg3),
                giden  : false,
            };
            0x2::event::emit<Odendi>(v0);
        } else {
            let v1 = arg0.giden_sayisi;
            let v2 = Giden<T0>{
                zincir : arg1,
                alici  : arg2,
                para   : arg3,
            };
            0x2::table::add<u64, Giden<T0>>(&mut arg0.giden, v1, v2);
            arg0.giden_sayisi = v1 + 1;
            let v3 = Odendi{
                zincir : arg1,
                alici  : arg2,
                miktar : 0x2::balance::value<T0>(&arg3),
                giden  : true,
            };
            0x2::event::emit<Odendi>(v3);
        };
    }

    fun oran(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun paylas<T0>(arg0: Kasa<T0>) {
        0x2::transfer::share_object<Kasa<T0>>(arg0);
    }

    public(friend) fun sat_emri<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u32, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 > 0) {
            if (arg2 > 0) {
                arg2 <= arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        if (arg4) {
            let v1 = oran(dolar_bakiye<T0>(arg0, arg1), arg2, arg3);
            if (v1 > 0) {
                let v2 = dolar_mut<T0>(arg0, arg1);
                ode<T0>(arg0, arg5, arg6, 0x2::balance::split<T0>(v2, v1), arg8);
            };
        };
        let v3 = oran(bakiye<T0, T1>(arg0, arg1), arg2, arg3);
        if (v3 == 0) {
            return
        };
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        let (v5, v6) = son_fiyat<T0>(arg0, v4);
        let v7 = oran(v3, v5, v6);
        let v8 = v7;
        if (v7 == 0) {
            v8 = 1;
        };
        let v9 = varlik_mut<T0, T1>(arg0, arg1);
        let v10 = 0x2::balance::split<T1>(v9, v3);
        let v11 = EmanetKey{ihale: arg0.ihale_sayisi};
        0x2::dynamic_field::add<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v11, v10);
        ilan<T0>(arg0, 2, arg1, v4, v3, v8 * 2, arg5, arg6, arg7);
    }

    fun son_fiyat<T0>(arg0: &Kasa<T0>, arg1: 0x1::type_name::TypeName) : (u64, u64) {
        let v0 = FiyatKey{varlik: arg1};
        if (0x2::dynamic_field::exists<FiyatKey>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<FiyatKey, Fiyat>(&arg0.id, v0);
            (v3.dolar, v3.varlik)
        } else {
            (0, 0)
        }
    }

    fun taahhut<T0>(arg0: &Kasa<T0>, arg1: u64) : u64 {
        let v0 = TaahhutKey{launch: arg1};
        if (0x2::dynamic_field::exists<TaahhutKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<TaahhutKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun taahhut_yaz<T0>(arg0: &mut Kasa<T0>, arg1: u64, arg2: u64) {
        let v0 = TaahhutKey{launch: arg1};
        if (0x2::dynamic_field::exists<TaahhutKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<TaahhutKey, u64>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<TaahhutKey, u64>(&mut arg0.id, v0, arg2);
        };
    }

    public fun tip_kimligi<T0>() : address {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x2::address::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun uygula_al<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow<u64, Emir>(&arg0.emirler, arg1);
        assert!(!v0.yapildi, 9);
        assert!(v0.tur == 2 && v0.varlik == tip_kimligi<T1>(), 5);
        let v1 = v0.dolar;
        let v2 = v0.ref;
        assert!(0x2::balance::value<T0>(&arg0.havuz) >= v1, 8);
        0x2::table::borrow_mut<u64, Emir>(&mut arg0.emirler, arg1).yapildi = true;
        let v3 = 0x2::balance::split<T0>(&mut arg0.havuz, v1);
        al_emri<T0, T1>(arg0, v0.launch, v3, v2, arg2);
    }

    public fun uygula_sat<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, Emir>(&arg0.emirler, arg1);
        assert!(!v0.yapildi, 9);
        assert!(v0.tur == 3 && v0.varlik == tip_kimligi<T1>(), 5);
        0x2::table::borrow_mut<u64, Emir>(&mut arg0.emirler, arg1).yapildi = true;
        sat_emri<T0, T1>(arg0, v0.launch, v0.miktar, v0.arz, v0.ilk, v0.hedef_zincir, v0.alici, arg2, arg3);
    }

    fun varlik_mut<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64) : &mut 0x2::balance::Balance<T1> {
        let v0 = VarlikKey{
            launch : arg1,
            varlik : 0x1::type_name::with_defining_ids<T1>(),
        };
        if (!0x2::dynamic_field::exists<VarlikKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<VarlikKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, 0x2::balance::zero<T1>());
        };
        0x2::dynamic_field::borrow_mut<VarlikKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v0)
    }

    public(friend) fun yeni<T0>(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : Kasa<T0> {
        Kasa<T0>{
            id           : 0x2::object::new(arg1),
            domain       : arg0,
            ihaleler     : 0x2::table::new<u64, Ihale>(arg1),
            ihale_sayisi : 0,
            giden        : 0x2::table::new<u64, Giden<T0>>(arg1),
            giden_sayisi : 0,
            havuz        : 0x2::balance::zero<T0>(),
            emirler      : 0x2::table::new<u64, Emir>(arg1),
            emir_sayisi  : 0,
        }
    }

    public fun yeniden_baslat<T0>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<u64, Ihale>(&mut arg0.ihaleler, arg1);
        assert!(!v0.bitti, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.baslama + 4 * 1800000 + 86400000, 3);
        v0.baslangic = v0.baslangic / 16;
        if (v0.baslangic == 0) {
            v0.baslangic = 1;
        };
        v0.baslama = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v7
}

