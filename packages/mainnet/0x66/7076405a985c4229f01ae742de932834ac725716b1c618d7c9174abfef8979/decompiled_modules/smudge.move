module 0x667076405a985c4229f01ae742de932834ac725716b1c618d7c9174abfef8979::smudge {
    struct SMUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUDGE>(arg0, 9, b"Smudge", b"Trench Kitty", b"Smudge is the only kitty that can save the trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRiXSCgiLExNVuSQR26tbAABsVui4MCD4Pnos88XfpHwj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMUDGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMUDGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUDGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

