module 0x8dfa25c5b3be24fd4d7583263f875fea42fd6ae06586875ae7f0df76561ef7cf::spl0 {
    struct SPL0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL0>(arg0, 6, b"SPL0", b"SPLOSPLASH", b"All in, all splash, that's SPLO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_214522801_1d4ec637f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPL0>>(v1);
    }

    // decompiled from Move bytecode v6
}

