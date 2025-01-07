module 0x83e6571118eaca12d7d428ae06341a8063711bc9983e0d6cefb3790a26b9d62c::SDOGE {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SDOGE>, arg1: 0x2::coin::Coin<SDOGE>) {
        0x2::coin::burn<SDOGE>(arg0, arg1);
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"Sui Doge", b"SDOGE", b"Suidoge is the first ecosystem focused meme coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmc4rzRTCGZiZkTKtA1hZMd9LG6eK2wTTMjo5ZFh6QiJma")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
        0x2::coin::mint_and_transfer<SDOGE>(&mut v2, 1000000000000000, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v2, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
    }

    // decompiled from Move bytecode v6
}

