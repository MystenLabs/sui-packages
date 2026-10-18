module 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::haberci {
    struct HaberciYetki has drop {
        dummy_field: bool,
    }

    struct Haberci has key {
        id: 0x2::object::UID,
        kasa: address,
        defter_zincir: u32,
        defter: address,
        ikiz: 0x2::table::Table<u32, address>,
        kurucu: 0x1::option::Option<address>,
    }

    public fun bilet(arg0: vector<u8>, arg1: vector<u8>) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::ReceiveMessageTicket<HaberciYetki> {
        let v0 = HaberciYetki{dummy_field: false};
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<HaberciYetki>(v0, arg0, arg1)
    }

    fun dilim(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun gideni_gonder<T0: drop>(arg0: &mut 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::Kasa<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T0, HaberciYetki> {
        let (v0, v1, v2) = 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::gideni_al<T0>(arg0, arg1);
        let v3 = HaberciYetki{dummy_field: false};
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T0, HaberciYetki>(0x2::coin::from_balance<T0>(v2, arg2), v0, v1, @0x0, 0, 2000, b"", v3)
    }

    public fun ikiz_ekle(arg0: &mut Haberci, arg1: u32, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.kurucu == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 1);
        assert!(!0x2::table::contains<u32, address>(&arg0.ikiz, arg1), 7);
        0x2::table::add<u32, address>(&mut arg0.ikiz, arg1, arg2);
    }

    public fun isle<T0>(arg0: &Haberci, arg1: &mut 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::Kasa<T0>, arg2: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::StampReceiptTicket<HaberciYetki> {
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::recipient(&arg2) == yetki_kimligi(), 3);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::finality_threshold_executed(&arg2) >= 2000, 5);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(&arg2);
        assert!(0x2::table::contains<u32, address>(&arg0.ikiz, v0), 2);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::sender(&arg2) == *0x2::table::borrow<u32, address>(&arg0.ikiz, v0), 3);
        assert!(0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::kimlik<T0>(arg1) == arg0.kasa, 6);
        let v1 = *0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(&arg2);
        assert!(v0 == arg0.defter_zincir && kelime_adres(&v1, 0) == arg0.defter, 4);
        assert!(kelime_adres(&v1, 32) == arg0.kasa, 6);
        let v2 = dilim(&v1, 160, (kelime_u256(&v1, 128) as u64));
        let v3 = (kelime_u256(&v2, 0) as u8);
        if (v3 == 2) {
            0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::emir_kaydet<T0>(arg1, 2, (kelime_u256(&v2, 32) as u64), kelime_adres(&v2, 64), u64e(kelime_u256(&v1, 96)), u64e(kelime_u256(&v2, 96)), 0, 0, false, 0, @0x0);
        } else {
            assert!(v3 == 3, 3);
            let v4 = (kelime_u256(&v2, 64) as u64);
            let v5 = kelime_u256(&v2, 96);
            let v6 = kelime_u256(&v2, 128);
            while (v6 > 18446744073709551615) {
                v6 = v6 >> 1;
                v5 = v5 >> 1;
            };
            let v7 = 0;
            while (v7 < (kelime_u256(&v2, v4) as u64)) {
                0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::emir_kaydet<T0>(arg1, 3, (kelime_u256(&v2, 32) as u64), kelime_adres(&v2, v4 + 32 + 32 * v7), 0, 0, (v5 as u64), (v6 as u64), v7 == 0, (kelime_u256(&v2, 160) as u32), kelime_adres(&v2, 192));
                v7 = v7 + 1;
            };
        };
        let v8 = HaberciYetki{dummy_field: false};
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_stamp_receipt_ticket<HaberciYetki>(v8, arg2)
    }

    fun kelime_adres(arg0: &vector<u8>, arg1: u64) : address {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun kelime_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun kilitle(arg0: &mut Haberci, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.kurucu == 0x1::option::some<address>(0x2::tx_context::sender(arg1)), 1);
        arg0.kurucu = 0x1::option::none<address>();
    }

    public fun kur<T0>(arg0: u32, arg1: u32, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::yeni<T0>(arg0, arg3);
        let v1 = Haberci{
            id            : 0x2::object::new(arg3),
            kasa          : 0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::kimlik<T0>(&v0),
            defter_zincir : arg1,
            defter        : arg2,
            ikiz          : 0x2::table::new<u32, address>(arg3),
            kurucu        : 0x1::option::some<address>(0x2::tx_context::sender(arg3)),
        };
        0x4a22de4e2b7621b1f6c09a0c5e5c04b1f4d205eb53c7131c154cff055c68dc1b::kasa::paylas<T0>(v0);
        0x2::transfer::share_object<Haberci>(v1);
    }

    fun u64e(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    public fun yetki_kimligi() : address {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<HaberciYetki>()
    }

    // decompiled from Move bytecode v7
}

