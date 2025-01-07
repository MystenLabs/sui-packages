module 0x360d79f00a919067c851359f536a1728c8e09caee636d0d553051f0e1177bd99::aifrens {
    struct AIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: 0x2::coin::Coin<AIFRENS>) {
        0x2::coin::burn<AIFRENS>(arg0, arg1);
    }

    fun init(arg0: AIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFRENS>(arg0, 6, b"AIFRENS", b"SuiFrens AI | #StandWithFrens", b"Twitter: @suifrensai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1651159721662119936/XSDUIcxA_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIFRENS>>(v1);
        0x2::coin::mint_and_transfer<AIFRENS>(&mut v2, 250000000000000, 0x2::address::from_u256(66920849298448499557149012513372938144461087335741058530790534045972084937971), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFRENS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIFRENS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

