module 0x5a0cd0721adbdb3cbefbd127a2e03f5ab057c5104f4491c4d4ee5811770b190c::hcore {
    struct HCORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCORE>(arg0, 6, b"HCORE", b"HOPECORE", b"Daily HOPECORE COntent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_11_34_25_f99fe895_21ce1c9940.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

