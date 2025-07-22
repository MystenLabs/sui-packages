module 0xe8db952882354188beaaa8d87ccd31c437c46ef8163e37f230de077ca6ca1ac5::bye {
    struct BYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYE>(arg0, 6, b"BYE", b"ByePow", b"\"The Chairman is gone. The memes remain.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753201707508.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

