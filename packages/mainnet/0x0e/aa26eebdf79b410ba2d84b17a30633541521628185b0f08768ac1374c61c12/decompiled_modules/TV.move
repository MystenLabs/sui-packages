module 0xeaa26eebdf79b410ba2d84b17a30633541521628185b0f08768ac1374c61c12::TV {
    struct TV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TV>(arg0, 6, b"TV", b"Trump Vader", b"May the 4th be with you...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmRHbcPWZL5rwcDQdv2zTemnmida47PZaQ6qB22nfaYdgu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

