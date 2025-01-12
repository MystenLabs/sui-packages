module 0xb1ae5133d8817ee3fe2290f7652a6b5c91dfe06cf7eed74aac30bc43baa616bc::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uniswap", b"meme uniswap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/447fb60d-bdd2-4b36-93bb-9031af919a7a.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

