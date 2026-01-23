module 0x78310e5d1a8debd962d812124e9cd23a0f15e7aefb2bb70b57a746b6f46c01bc::badges {
    struct BADGES has drop {
        dummy_field: bool,
    }

    public entry fun grant_badge(arg0: &mut 0x2::coin::TreasuryCap<BADGES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BADGES>>(0x2::coin::mint<BADGES>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BADGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADGES>(arg0, 9, b"BADGE", b"Achievement Badge", b"Protocol milestone achievement recognition badge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://achieve.system.net/badge.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADGES>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BADGES>>(v0);
    }

    public entry fun revoke_badge(arg0: &mut 0x2::coin::TreasuryCap<BADGES>, arg1: 0x2::coin::Coin<BADGES>) {
        0x2::coin::burn<BADGES>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

