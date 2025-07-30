module 0xb2f00de76f00370b3dfa2fe12f0af2114cfbd1b05a94ee54bcbee66c536daaab::MYF {
    struct MYF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYF>(arg0, 6, b"Mystiq Fairy", b"MYF", b"A whimsical and enchanting meme coin inspired by the magic of fairies. Mystiq Fairy brings a touch of fantasy and mystery to the crypto world, perfect for those who believe in the power of dreams and digital gold dust. Spread the magic, hodl the sparkle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/fiRxWEzLYLRydyzGZ2sjbM1YcWsAnVbVZOuurIbWEqiJ3fFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYF>>(v0, @0xcefdcee542d102456218259052e8feae0f9a7216378d56e8d5d10cca74d99ffe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYF>>(v1);
    }

    // decompiled from Move bytecode v6
}

