module 0x6aa03a9dc71d89ee86827ecfe58a840f34c7b6e5ecb5f2ee00495084e18b0b33::trollface {
    struct TROLLFACE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<TROLLFACE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TROLLFACE>>(arg0, arg1);
    }

    fun init(arg0: TROLLFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLFACE>(arg0, 6, b"$TFACE ", b"TrollFace ", b"We are TROLLFACE #1 meme coin on Sui Network Lets make memecoins great again. #MMGA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ZVS7G5t.jpeg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TROLLFACE>(&mut v2, 600000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLFACE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

