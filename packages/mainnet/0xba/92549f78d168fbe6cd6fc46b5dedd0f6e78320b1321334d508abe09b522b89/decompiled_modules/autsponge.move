module 0xba92549f78d168fbe6cd6fc46b5dedd0f6e78320b1321334d508abe09b522b89::autsponge {
    struct AUTSPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTSPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTSPONGE>(arg0, 6, b"AUTSPONGE", b"Spongebob The Autistic", b"fully degen sponge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/autspong_dc7dc664bb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTSPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTSPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

