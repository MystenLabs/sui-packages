module 0x547b04d10eb0bf354fcce7b959aa25dd17fb272bba9105aeaaa2e3a17430cb4::foxemo {
    struct FOXEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXEMO>(arg0, 6, b"FOXEMO", b"Fox Emoji", b"Fox Emoji on Solana , the first utility token in the EmojiFi ecosystem. Bet and win in our upcoming EmojiFi Roulette at the Fox Emoji Casino", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111111_8cd9e96c5a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

