module 0x9172c2d0d14768c9e7727cf21b3f0669d80bf21ecf28ed8517b269ad70ac299e::wigo {
    struct WIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGO>(arg0, 6, b"WIGO", b"Wigo Swap", b"Wigo Swap on sui is the first DEX with rewards for community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wigoswap_dex_82fd9b2ef6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

