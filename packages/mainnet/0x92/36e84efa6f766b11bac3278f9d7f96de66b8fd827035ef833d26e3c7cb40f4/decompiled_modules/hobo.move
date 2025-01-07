module 0x9236e84efa6f766b11bac3278f9d7f96de66b8fd827035ef833d26e3c7cb40f4::hobo {
    struct HOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBO>(arg0, 6, b"HOBO", b"hobo", b"Im just a homeless man creating a token in my situation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silverhobotoken500pixels_e6585397e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

