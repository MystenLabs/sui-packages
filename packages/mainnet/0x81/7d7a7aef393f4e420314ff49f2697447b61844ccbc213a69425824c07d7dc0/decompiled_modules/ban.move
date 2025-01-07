module 0x817d7a7aef393f4e420314ff49f2697447b61844ccbc213a69425824c07d7dc0::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"Ban", b"ban", b"$Banana - About Banana: is a fun and quirky MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731080190303.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

