module 0xd1940e6b73f3accfce31ad5b83da0d0f1770a4fc0bf69e6624bffd39ab5f535b::coins {
    struct COINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINS>(arg0, 6, b"AQUAMAN", b"King of the ocean", b"We are leader of the sui season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746788809420029952/D9IPS4UP_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINS>>(v1);
        0x2::coin::mint_and_transfer<COINS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun renounceOwnership(arg0: 0x2::coin::TreasuryCap<COINS>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINS>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

