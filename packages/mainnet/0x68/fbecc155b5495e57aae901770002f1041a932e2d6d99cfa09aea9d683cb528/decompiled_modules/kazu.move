module 0x68fbecc155b5495e57aae901770002f1041a932e2d6d99cfa09aea9d683cb528::kazu {
    struct KAZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAZU>(arg0, 6, b"KAZU", b"Kazumi The little Kaiju", b"Nom Nom Rawr!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig53mr2qiysgnxahxbr3n42rexykoi3z4inyejrfoy2ykgv6iyise")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAZU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

