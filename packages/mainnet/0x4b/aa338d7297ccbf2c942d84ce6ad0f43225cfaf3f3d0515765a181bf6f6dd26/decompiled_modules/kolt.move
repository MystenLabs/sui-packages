module 0x4baa338d7297ccbf2c942d84ce6ad0f43225cfaf3f3d0515765a181bf6f6dd26::kolt {
    struct KOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLT>(arg0, 6, b"KOLT", b"Sui Kolt", b"Kolt is the coolest cat on SUI. Inspired by the Legendary drawings of Matt Furies' Boy's Club Comic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_6446cc6be4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

