module 0xd0f430beaf2dd7a6df7b5483026b7b2806d077496ce425224e9589f15f435266::coinex {
    struct COINEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINEX>(arg0, 9, b"COINEX", b"CoinEx", b"COINEX Coin is a Meme coin, COINEX released First on SUI blockchain with inspiration and main image from the COINEX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2121eab5-1c50-4ebe-a07d-846d188d76ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

