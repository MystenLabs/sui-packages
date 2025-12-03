module 0x143644522e70d8521ffa8eaec16c4cd4a06ece112f6ecd0341cb58f9cba55f67::avc {
    struct AVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVC>(arg0, 3, b"AVC", b"Aureum Voyagia Coin", b"Travel Crypto Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://chatgpt.com/s/m_6930993bc6148191951029871259bd46")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVC>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVC>>(v2, @0x5435ac599bf29f2d3f2f9a6b5d5fb0481987166d89e820bdcb17d5b47470ca29);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

