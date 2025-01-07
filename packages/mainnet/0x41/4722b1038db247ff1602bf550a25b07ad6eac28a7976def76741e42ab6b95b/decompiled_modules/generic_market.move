module 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::generic_market {
    struct GENERIC_MARKET has drop {
        dummy_field: bool,
    }

    public fun createRack<T0: store + key, T1>(arg0: &0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::PKAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::createPublicKiosk<T0, T1>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_share_object<0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault>(v1);
    }

    fun init(arg0: GENERIC_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::list<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun place<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::place<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun placeAndList<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::placeAndList<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun purchase<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::KioskVault, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk::purchase<T0, T1>(arg0, arg1, arg2, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::object::id<T0>(&v5) == 0x2::transfer_policy::item<T0>(&v4), 4002);
        0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::generic_policy::pay<T0, T1>(&mut v4, &v3, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v4);
        0x2::transfer::public_transfer<T0>(v5, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

