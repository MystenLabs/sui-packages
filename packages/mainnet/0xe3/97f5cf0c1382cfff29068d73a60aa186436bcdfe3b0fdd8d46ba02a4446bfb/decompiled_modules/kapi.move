module 0xe397f5cf0c1382cfff29068d73a60aa186436bcdfe3b0fdd8d46ba02a4446bfb::kapi {
    struct KAPI has drop {
        dummy_field: bool,
    }

    struct Kapi has key {
        id: 0x2::object::UID,
        cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp: address,
        aktarma_eid: u32,
        kurucu: 0x1::option::Option<address>,
        adlar: 0x2::table::Table<address, Ad>,
        tipler: 0x2::table::Table<address, 0x1::type_name::TypeName>,
        bekleyen: 0x2::table::Table<u64, Basim>,
        sayac: u64,
    }

    struct Ad has copy, drop, store {
        ad: 0x1::string::String,
        sembol: 0x1::string::String,
    }

    struct Basim has drop, store {
        token: address,
        alici: address,
        miktar: u64,
    }

    struct Beklenen has copy, drop {
        token: address,
        ad: 0x1::string::String,
        sembol: 0x1::string::String,
    }

    struct Kaydedildi has copy, drop {
        token: address,
        tip: 0x1::type_name::TypeName,
    }

    struct Geldi has copy, drop {
        token: address,
        alici: address,
        miktar: u64,
    }

    struct Bekliyor has copy, drop {
        sira: u64,
        token: address,
        alici: address,
        miktar: u64,
    }

    struct Gitti has copy, drop {
        token: address,
        gonderen: address,
        alici: address,
        miktar: u64,
        istekli: bool,
    }

    public fun lz_receive(arg0: &mut Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = al(arg0, arg1, arg2, arg3);
        isle(arg0, &v0);
    }

    public fun ad(arg0: &Ad) : 0x1::string::String {
        arg0.ad
    }

    fun ad_duzelt(arg0: vector<u8>) : 0x1::string::String {
        if (0x1::vector::length<u8>(&arg0) > 32) {
            let v0 = 32;
            while (v0 > 0 && *0x1::vector::borrow<u8>(&arg0, v0) & 192 == 128) {
                v0 = v0 - 1;
            };
            while (0x1::vector::length<u8>(&arg0) > v0) {
                0x1::vector::pop_back<u8>(&mut arg0);
            };
        };
        let v1 = 0x1::string::try_utf8(arg0);
        if (0x1::option::is_some<0x1::string::String>(&v1)) {
            0x1::option::destroy_some<0x1::string::String>(v1)
        } else {
            0x1::string::utf8(b"")
        }
    }

    fun adres(arg0: &vector<u8>, arg1: u64) : address {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun al(arg0: &Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::tx_context::TxContext) : vector<u8> {
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp, 3);
        let (_, _, _, _, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.cap, arg2));
        let v8 = v7;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
        v4
    }

    fun alan(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = (kelime(arg0, arg1) as u64);
        let v1 = b"";
        let v2 = 0;
        while (v2 < (kelime(arg0, v0) as u64)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0 + 32 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun bas<T0>(arg0: &mut Kapi, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let Basim {
            token  : v0,
            alici  : v1,
            miktar : v2,
        } = 0x2::table::remove<u64, Basim>(&mut arg0.bekleyen, arg1);
        basip_ver<T0>(arg0, v0, v1, v2, arg2);
    }

    fun basip_ver<T0>(arg0: &mut Kapi, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.tipler, arg1), 13);
        assert!(*0x2::table::borrow<address, 0x1::type_name::TypeName>(&arg0.tipler, arg1) == 0x1::type_name::with_defining_ids<T0>(), 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(0x2::dynamic_field::borrow_mut<address, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg1), arg3, arg4), arg2);
        let v0 = Geldi{
            token  : arg1,
            alici  : arg2,
            miktar : arg3,
        };
        0x2::event::emit<Geldi>(v0);
    }

    public fun beklenen(arg0: &Kapi, arg1: address) : 0x1::option::Option<Ad> {
        if (0x2::table::contains<address, Ad>(&arg0.adlar, arg1)) {
            0x1::option::some<Ad>(*0x2::table::borrow<address, Ad>(&arg0.adlar, arg1))
        } else {
            0x1::option::none<Ad>()
        }
    }

    public fun bekleyen_sayisi(arg0: &Kapi) : u64 {
        0x2::table::length<u64, Basim>(&arg0.bekleyen)
    }

    fun giden(arg0: address, arg1: vector<u8>, arg2: u64, arg3: vector<u8>) : vector<u8> {
        let v0 = w((2 as u256));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, w((arg2 as u256)));
        0x1::vector::append<u8>(&mut v0, w(160));
        0x1::vector::append<u8>(&mut v0, w((0x1::vector::length<u8>(&arg3) as u256)));
        0x1::vector::append<u8>(&mut v0, arg3);
        while (0x1::vector::length<u8>(&v0) % 32 != 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
        };
        v0
    }

    public fun gonder<T0>(arg0: &mut Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp, 3);
        assert!(0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.tipler, arg2), 13);
        assert!(*0x2::table::borrow<address, 0x1::type_name::TypeName>(&arg0.tipler, arg2) == 0x1::type_name::with_defining_ids<T0>(), 12);
        assert!(0x1::vector::length<u8>(&arg4) == 32 && arg4 != w(0), 15);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 14);
        0x2::coin::burn<T0>(0x2::dynamic_field::borrow_mut<address, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg2), arg3);
        let v1 = Gitti{
            token    : arg2,
            gonderen : 0x2::tx_context::sender(arg7),
            alici    : 0x2::address::from_bytes(arg4),
            miktar   : v0,
            istekli  : !0x1::vector::is_empty<u8>(&arg5),
        };
        0x2::event::emit<Gitti>(v1);
        let v2 = arg0.aktarma_eid;
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send_and_refund(arg1, &arg0.cap, v2, giden(arg2, arg4, v0, arg5), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg1, v2, 1, b""), arg6, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x2::tx_context::sender(arg7), arg7)
    }

    fun init(arg0: KAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<KAPI>(&arg0, arg1);
        let v3 = yeni(v0, v2, arg1);
        0x2::transfer::share_object<Kapi>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun isle(arg0: &mut Kapi, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) >= 128, 4);
        let v0 = kelime(arg1, 0);
        let v1 = adres(arg1, 32);
        if (v0 == (1 as u256)) {
            if (0x2::table::contains<address, Ad>(&arg0.adlar, v1) || 0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.tipler, v1)) {
                return
            };
            let v2 = Ad{
                ad     : ad_duzelt(alan(arg1, 64)),
                sembol : sembol_duzelt(alan(arg1, 96)),
            };
            let v3 = Beklenen{
                token  : v1,
                ad     : v2.ad,
                sembol : v2.sembol,
            };
            0x2::event::emit<Beklenen>(v3);
            0x2::table::add<address, Ad>(&mut arg0.adlar, v1, v2);
        } else {
            assert!(v0 == (2 as u256), 4);
            let (v4, v5) = tasi_oku(arg1);
            let v6 = arg0.sayac;
            arg0.sayac = v6 + 1;
            let v7 = Basim{
                token  : v1,
                alici  : v4,
                miktar : v5,
            };
            0x2::table::add<u64, Basim>(&mut arg0.bekleyen, v6, v7);
            let v8 = Bekliyor{
                sira   : v6,
                token  : v1,
                alici  : v4,
                miktar : v5,
            };
            0x2::event::emit<Bekliyor>(v8);
        };
    }

    public(friend) fun isle_tip<T0>(arg0: &mut Kapi, arg1: &vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(arg1) >= 128 && kelime(arg1, 0) == (2 as u256), 4);
        let (v0, v1) = tasi_oku(arg1);
        basip_ver<T0>(arg0, adres(arg1, 32), v0, v1, arg2);
    }

    public fun kaydet<T0>(arg0: &mut Kapi, arg1: address, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::TreasuryCap<T0>) {
        assert!(0x2::table::contains<address, Ad>(&arg0.adlar, arg1), 5);
        let v0 = 0x2::table::remove<address, Ad>(&mut arg0.adlar, arg1);
        assert!(0x2::coin_registry::name<T0>(arg2) == v0.ad && 0x2::coin_registry::symbol<T0>(arg2) == v0.sembol, 6);
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 6, 7);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 8);
        let v1 = if (!0x2::coin_registry::is_regulated<T0>(arg2)) {
            let v2 = 0x2::coin_registry::deny_cap_id<T0>(arg2);
            0x1::option::is_none<0x2::object::ID>(&v2)
        } else {
            false
        };
        assert!(v1, 9);
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg2), 10);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg3)), 11);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        0x2::dynamic_field::add<address, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg1, arg3);
        0x2::table::add<address, 0x1::type_name::TypeName>(&mut arg0.tipler, arg1, v3);
        let v4 = Kaydedildi{
            token : arg1,
            tip   : v3,
        };
        0x2::event::emit<Kaydedildi>(v4);
    }

    public fun kaydol(arg0: &Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), b"", lz_receive_info(arg0, arg1), b"");
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::register_oapp(arg1, arg2, arg3, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0), arg4);
    }

    fun kelime(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun kur(arg0: &mut Kapi, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.kurucu == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 1);
        assert!(arg0.aktarma_eid == 0, 2);
        arg0.aktarma_eid = arg1;
        arg0.kurucu = 0x1::option::none<address>();
    }

    public fun lz_receive_info(arg0: &Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<Kapi>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<Kapi>(), 0x1::ascii::string(b"kapi"), 0x1::ascii::string(b"lz_receive_ptb"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v3, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v2));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v3)
    }

    public fun lz_receive_ptb(arg0: &Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = tip_sec(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg2)));
        let (v1, v2) = if (0x1::option::is_some<0x1::type_name::TypeName>(&v0)) {
            let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0));
            (b"lz_receive_tip", v3)
        } else {
            (b"lz_receive", 0x1::vector::empty<0x1::type_name::TypeName>())
        };
        let v4 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<Kapi>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        let v6 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<Kapi>(), 0x1::ascii::string(b"kapi"), 0x1::ascii::string(v1), v4, v2, false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        v6
    }

    public fun lz_receive_tip<T0>(arg0: &mut Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = al(arg0, arg1, arg2, arg3);
        isle_tip<T0>(arg0, &v0, arg3);
    }

    public fun sembol(arg0: &Ad) : 0x1::string::String {
        arg0.sembol
    }

    fun sembol_duzelt(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0) && 0x1::vector::length<u8>(&v0) < 10) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 >= 32 && v2 <= 126) {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::string::utf8(v0)
    }

    fun tasi_oku(arg0: &vector<u8>) : (address, u64) {
        let v0 = kelime(arg0, 96);
        assert!(v0 <= 18446744073709551615, 16);
        (adres(arg0, 64), (v0 as u64))
    }

    public fun teklif(arg0: &Kapi, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp, 3);
        let v0 = arg0.aktarma_eid;
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.cap, v0, giden(arg2, arg3, arg4, arg5), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg1, v0, 1, b""), false, arg6)
    }

    public fun tip(arg0: &Kapi, arg1: address) : 0x1::option::Option<0x1::type_name::TypeName> {
        if (0x2::table::contains<address, 0x1::type_name::TypeName>(&arg0.tipler, arg1)) {
            0x1::option::some<0x1::type_name::TypeName>(*0x2::table::borrow<address, 0x1::type_name::TypeName>(&arg0.tipler, arg1))
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    public fun tip_sec(arg0: &Kapi, arg1: &vector<u8>) : 0x1::option::Option<0x1::type_name::TypeName> {
        if (0x1::vector::length<u8>(arg1) < 128 || kelime(arg1, 0) != (2 as u256)) {
            return 0x1::option::none<0x1::type_name::TypeName>()
        };
        tip(arg0, adres(arg1, 32))
    }

    fun w(arg0: u256) : vector<u8> {
        let v0 = b"";
        let v1 = 32;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> ((v1 * 8) as u8) & 255) as u8));
        };
        v0
    }

    fun yeni(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Kapi {
        Kapi{
            id          : 0x2::object::new(arg2),
            cap         : arg0,
            oapp        : arg1,
            aktarma_eid : 0,
            kurucu      : 0x1::option::some<address>(0x2::tx_context::sender(arg2)),
            adlar       : 0x2::table::new<address, Ad>(arg2),
            tipler      : 0x2::table::new<address, 0x1::type_name::TypeName>(arg2),
            bekleyen    : 0x2::table::new<u64, Basim>(arg2),
            sayac       : 0,
        }
    }

    // decompiled from Move bytecode v7
}

