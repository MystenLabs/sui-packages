module 0x34ac0ac61f4f37a1d505ab499a9406200b7edb7b760a9892e7957d81daf4310::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"Wave", b"Wave Meme on SUI", b"Introducing Wave Coin: The SUI Blockchain's Answer to Memetic Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_13_6136d2e403.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

