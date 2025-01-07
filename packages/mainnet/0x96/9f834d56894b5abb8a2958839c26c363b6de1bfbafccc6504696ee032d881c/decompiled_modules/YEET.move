module 0x969f834d56894b5abb8a2958839c26c363b6de1bfbafccc6504696ee032d881c::YEET {
    struct YEET has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YEET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YEET>>(0x2::coin::mint<YEET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: YEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEET>(arg0, 9, b"Suifrens", b"SFRENS", b"Top 1 MEME on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654044209735942145/h49JnKkb_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YEET>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEET>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<YEET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YEET>>(0x2::coin::mint<YEET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

