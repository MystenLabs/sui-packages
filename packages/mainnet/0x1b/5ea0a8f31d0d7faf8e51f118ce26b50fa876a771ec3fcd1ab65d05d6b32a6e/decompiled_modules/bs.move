module 0x1b5ea0a8f31d0d7faf8e51f118ce26b50fa876a771ec3fcd1ab65d05d6b32a6e::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 6, b"BS", b"Bullshit", b"Can bullshit make billionaires - only one way to find out ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009466_4b416273bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

