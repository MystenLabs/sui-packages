module 0x5937db7cebc3125f8759fee8273dcbfee3d070ce4122a62d078df2c4c8a25376::create {
    struct CREATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATE>(arg0, 6, b"CREATE", b"create", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/removal_ai_ad94299c_eec5_4de5_aff6_a0063686d7b1_logo_85d9380d15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

