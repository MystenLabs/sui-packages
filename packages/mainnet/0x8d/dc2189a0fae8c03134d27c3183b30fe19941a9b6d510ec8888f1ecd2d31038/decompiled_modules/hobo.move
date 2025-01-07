module 0x8ddc2189a0fae8c03134d27c3183b30fe19941a9b6d510ec8888f1ecd2d31038::hobo {
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

