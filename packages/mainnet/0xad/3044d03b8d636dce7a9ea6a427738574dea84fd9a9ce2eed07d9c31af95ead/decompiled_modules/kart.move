module 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart {
    struct KART has drop {
        dummy_field: bool,
    }

    fun init(arg0: KART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KART>(arg0, 9, b"KARTCOIN", b"KART", b"Coin for KartScription Protocal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://frg7dte4lrdoiwykfwfc7coqobyhvnspqdodr6nufgi6dcdwit5a.arweave.net/LE3xzJxcRuRbCi2KL4nQcHB6tk-A3Dj5tCmR4Yh2RPo")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KART>>(0x2::coin::mint<KART>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KART>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KART>>(v2);
    }

    public fun kart_decimals() : u8 {
        9
    }

    // decompiled from Move bytecode v6
}

