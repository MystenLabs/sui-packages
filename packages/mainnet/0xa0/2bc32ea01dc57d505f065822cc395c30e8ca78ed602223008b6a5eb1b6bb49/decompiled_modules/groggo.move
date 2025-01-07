module 0xa02bc32ea01dc57d505f065822cc395c30e8ca78ed602223008b6a5eb1b6bb49::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 9, b"GROGGO", b"Groggo", b"HOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x4d6f6e4c5d52ba4779626609349467debc3f7b0c.png?size=xl&key=a36967")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROGGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

