module 0x7d4da46c8eeb66b1b4f1dad54095456cdc2f7d6994e4fa06561863da3641006e::flydog {
    struct FLYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYDOG>(arg0, 6, b"FLYDOG", b"SUIFLYDOG", b"FLY FLY FLY#", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018226_5f5cb368c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

