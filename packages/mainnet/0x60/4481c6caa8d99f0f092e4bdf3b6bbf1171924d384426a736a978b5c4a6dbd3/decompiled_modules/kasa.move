module 0x7c0a195af1e87cd0ef263fa4e5753c5fa35c630537557977d16e6ac94c044ea4::kasa {
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

    struct ListeKey has copy, drop, store {
        varlik: 0x1::type_name::TypeName,
    }

    struct Liste has drop, store {
        havuz: 0x2::object::ID,
        dolar_a: bool,
        izci: u128,
        izci_ms: u64,
        tavan: u64,
    }

    struct Takas has copy, drop {
        ihale: u64,
        dolduran: address,
        verilen: u64,
        alinan: u64,
        kalan: u64,
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

    fun alim_acik<T0, T1>(arg0: &Kasa<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Ihale>(&arg0.ihaleler, arg1);
        assert!(!v0.bitti, 1);
        assert!(v0.tur == 1, 6);
        assert!(v0.varlik == 0x1::type_name::with_defining_ids<T1>(), 5);
        (v0.launch, v0.verilen, oran(v0.verilen, dolar_bakiye<T0>(arg0, v0.launch), taahhut<T0>(arg0, v0.launch)))
    }

    fun alim_yaz<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg7);
        let v1 = if (arg4 - arg5 < 1000000) {
            arg3
        } else {
            let v2 = oran(arg5, arg3, arg4);
            if (v2 == 0) {
                1
            } else if (v2 > arg3) {
                arg3
            } else {
                v2
            }
        };
        let v3 = taahhut<T0>(arg0, arg2) - v1;
        taahhut_yaz<T0>(arg0, arg2, v3);
        let v4 = 0x2::table::borrow_mut<u64, Ihale>(&mut arg0.ihaleler, arg1);
        if (v1 == arg3) {
            v4.bitti = true;
        } else {
            let v5 = oran(v4.baslangic, arg3 - v1, arg3);
            let v6 = if (v5 == 0) {
                1
            } else {
                v5
            };
            v4.baslangic = v6;
            v4.verilen = arg3 - v1;
        };
        let v7 = varlik_mut<T0, T1>(arg0, arg2);
        0x2::balance::join<T1>(v7, arg7);
        fiyat_yaz<T0>(arg0, 0x1::type_name::with_defining_ids<T1>(), arg6, v0);
        let v8 = Takas{
            ihale    : arg1,
            dolduran : 0x2::tx_context::sender(arg8),
            verilen  : arg6,
            alinan   : v0,
            kalan    : arg3 - v1,
        };
        0x2::event::emit<Takas>(v8);
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

    fun birim_tavani(arg0: u64, arg1: u128, arg2: bool) : u64 {
        let v0 = karsilik(arg0, arg1, !arg2);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
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

    fun en_az(arg0: u256) : u256 {
        arg0 * (10000 - 400) / 10000
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

    fun izle<T0, T1>(arg0: &mut Kasa<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u128, arg4: &0x2::clock::Clock) : (u128, u64) {
        let v0 = ListeKey{varlik: 0x1::type_name::with_defining_ids<T1>()};
        assert!(0x2::dynamic_field::exists<ListeKey>(&arg0.id, v0), 10);
        let v1 = 0x2::dynamic_field::borrow_mut<ListeKey, Liste>(&mut arg0.id, v0);
        assert!(v1.havuz == arg1 && v1.dolar_a == arg2, 11);
        let v2 = v1.izci;
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = ((v3 - v1.izci_ms) as u256) * 50 / 60000;
        let v5 = v4;
        if (v4 > 500) {
            v5 = 500;
        };
        let v6 = (v2 as u256);
        let v7 = v6 * (10000 - v5) / 10000;
        let v8 = v6 * (10000 + v5) / 10000;
        let v9 = (arg3 as u256);
        let v10 = if (v9 < v7) {
            v7
        } else if (v9 > v8) {
            v8
        } else {
            v9
        };
        if (v5 > 0) {
            v1.izci = (v10 as u128);
            v1.izci_ms = v3;
        };
        (v2, v1.tavan)
    }

    public fun izle_a<T0, T1>(arg0: &mut Kasa<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        let (_, _) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
    }

    public fun izle_b<T0, T1>(arg0: &mut Kasa<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        let (_, _) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1), false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), arg2);
    }

    public fun kabul<T0>(arg0: &mut Kasa<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x2::balance::join<T0>(&mut arg0.havuz, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
    }

    fun karsilik(arg0: u64, arg1: u128, arg2: bool) : u256 {
        let v0 = (arg1 as u256);
        if (arg2) {
            (arg0 as u256) * v0 / 18446744073709551616 * v0 / 18446744073709551616
        } else {
            (arg0 as u256) * 18446744073709551616 / v0 * 18446744073709551616 / v0
        }
    }

    public fun kimlik<T0>(arg0: &Kasa<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun liste<T0, T1>(arg0: &Kasa<T0>) : (0x2::object::ID, bool, u128, u64, u64) {
        let v0 = ListeKey{varlik: 0x1::type_name::with_defining_ids<T1>()};
        let v1 = 0x2::dynamic_field::borrow<ListeKey, Liste>(&arg0.id, v0);
        (v1.havuz, v1.dolar_a, v1.izci, v1.izci_ms, v1.tavan)
    }

    public(friend) fun liste_yaz<T0, T1>(arg0: &mut Kasa<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = ListeKey{varlik: 0x1::type_name::with_defining_ids<T1>()};
        if (0x2::dynamic_field::exists<ListeKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ListeKey, Liste>(&mut arg0.id, v0);
        };
        let v1 = Liste{
            havuz   : arg1,
            dolar_a : arg2,
            izci    : arg3,
            izci_ms : 0x2::clock::timestamp_ms(arg5),
            tavan   : arg4,
        };
        0x2::dynamic_field::add<ListeKey, Liste>(&mut arg0.id, v0, v1);
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

    fun satim_acik<T0, T1>(arg0: &Kasa<T0>, arg1: u64) : (u64, u32, address) {
        let v0 = 0x2::table::borrow<u64, Ihale>(&arg0.ihaleler, arg1);
        assert!(!v0.bitti, 1);
        assert!(v0.tur == 2, 6);
        assert!(v0.varlik == 0x1::type_name::with_defining_ids<T1>(), 5);
        (v0.verilen, v0.hedef_zincir, v0.alici)
    }

    fun satim_yaz<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: address, arg6: 0x2::balance::Balance<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg6);
        let v1 = if (v0 >= 1000000 + 50000) {
            50000
        } else {
            0
        };
        let v2 = 0x2::table::borrow_mut<u64, Ihale>(&mut arg0.ihaleler, arg1);
        if (arg3 == arg2) {
            v2.bitti = true;
        } else {
            let v3 = oran(v2.baslangic, arg2 - arg3, arg2);
            let v4 = if (v3 == 0) {
                1
            } else {
                v3
            };
            v2.baslangic = v4;
            v2.verilen = arg2 - arg3;
        };
        if (arg3 == arg2) {
            let v5 = EmanetKey{ihale: arg1};
            0x2::balance::destroy_zero<T1>(0x2::dynamic_field::remove<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v5));
        };
        fiyat_yaz<T0>(arg0, 0x1::type_name::with_defining_ids<T1>(), v0, arg3);
        let v6 = Takas{
            ihale    : arg1,
            dolduran : 0x2::tx_context::sender(arg7),
            verilen  : arg3,
            alinan   : v0,
            kalan    : arg2 - arg3,
        };
        0x2::event::emit<Takas>(v6);
        ode<T0>(arg0, arg4, arg5, arg6, arg7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg6, v1), arg7)
    }

    fun sinir(arg0: u128, arg1: u128, arg2: bool) : u128 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            v0 - v1
        };
        assert!(v2 * 10000 <= v0 * 150, 12);
        let v3 = if (arg2) {
            v0 * (10000 - 150) / 10000
        } else {
            v0 * (10000 + 150) / 10000
        };
        assert!(arg2 && v3 < v1 || v3 > v1, 12);
        (v3 as u128)
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

    public fun takas_al_a<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = alim_acik<T0, T1>(arg0, arg1);
        assert!(v2 > 50000, 4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v4, v5) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), true, v3, arg4);
        let v6 = v2 - 50000;
        let v7 = v6;
        if (v6 > v5) {
            v7 = v5;
        };
        let v8 = dolar_mut<T0>(arg0, v0);
        let v9 = 0x2::balance::split<T0>(v8, v7);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, v7, sinir(v4, v3, true), arg4);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut v9, v15), 0x2::balance::zero<T1>(), v13);
        0x2::balance::destroy_zero<T0>(v10);
        let v16 = dolar_mut<T0>(arg0, v0);
        0x2::balance::join<T0>(v16, v9);
        assert!(v15 > 0 && (0x2::balance::value<T1>(&v14) as u256) >= en_az(karsilik(v15, v4, true)), 2);
        let v17 = if (v15 >= 1000000) {
            50000
        } else {
            0
        };
        let v18 = dolar_mut<T0>(arg0, v0);
        alim_yaz<T0, T1>(arg0, arg1, v0, v1, v2, v15 + v17, v15, v14, arg5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v18, v17), arg5)
    }

    public fun takas_al_b<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = alim_acik<T0, T1>(arg0, arg1);
        assert!(v2 > 50000, 4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg3);
        let (v4, v5) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), false, v3, arg4);
        let v6 = v2 - 50000;
        let v7 = v6;
        if (v6 > v5) {
            v7 = v5;
        };
        let v8 = dolar_mut<T0>(arg0, v0);
        let v9 = 0x2::balance::split<T0>(v8, v7);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, false, true, v7, sinir(v4, v3, false), arg4);
        let v13 = v12;
        let v14 = v10;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v9, v15), v13);
        0x2::balance::destroy_zero<T0>(v11);
        let v16 = dolar_mut<T0>(arg0, v0);
        0x2::balance::join<T0>(v16, v9);
        assert!(v15 > 0 && (0x2::balance::value<T1>(&v14) as u256) >= en_az(karsilik(v15, v4, false)), 2);
        let v17 = if (v15 >= 1000000) {
            50000
        } else {
            0
        };
        let v18 = dolar_mut<T0>(arg0, v0);
        alim_yaz<T0, T1>(arg0, arg1, v0, v1, v2, v15 + v17, v15, v14, arg5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v18, v17), arg5)
    }

    public fun takas_sat_a<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = satim_acik<T0, T1>(arg0, arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v4, v5) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), true, v3, arg4);
        let v6 = v0;
        let v7 = birim_tavani(v5, v4, false);
        if (v0 > v7) {
            v6 = v7;
        };
        let v8 = EmanetKey{ihale: arg1};
        let v9 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v8), v6);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, v6, sinir(v4, v3, false), arg4);
        let v13 = v12;
        let v14 = v10;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, v15), v13);
        0x2::balance::destroy_zero<T1>(v11);
        let v16 = EmanetKey{ihale: arg1};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v16), v9);
        assert!(v15 > 0 && (0x2::balance::value<T0>(&v14) as u256) >= en_az(karsilik(v15, v4, false)), 2);
        satim_yaz<T0, T1>(arg0, arg1, v0, v15, v1, v2, v14, arg5)
    }

    public fun takas_sat_b<T0, T1>(arg0: &mut Kasa<T0>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = satim_acik<T0, T1>(arg0, arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg3);
        let (v4, v5) = izle<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), false, v3, arg4);
        let v6 = v0;
        let v7 = birim_tavani(v5, v4, true);
        if (v0 > v7) {
            v6 = v7;
        };
        let v8 = EmanetKey{ihale: arg1};
        let v9 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v8), v6);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, true, v6, sinir(v4, v3, true), arg4);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(&mut v9, v15), 0x2::balance::zero<T0>(), v13);
        0x2::balance::destroy_zero<T1>(v10);
        let v16 = EmanetKey{ihale: arg1};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<EmanetKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v16), v9);
        assert!(v15 > 0 && (0x2::balance::value<T0>(&v14) as u256) >= en_az(karsilik(v15, v4, true)), 2);
        satim_yaz<T0, T1>(arg0, arg1, v0, v15, v1, v2, v14, arg5)
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

