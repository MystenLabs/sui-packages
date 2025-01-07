module 0x606118719cda27f89168c98c1de02ff4b9e120da1c27dfdd1399b45d21f6a322::becat {
    struct BECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BECAT>(arg0, 6, b"beCAT", b"blue eyed cat", b"A blue-eyed cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_qimg_c5c1e3caf5b43ae0331e84d0d505b6c1_lq_30111e2c0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

