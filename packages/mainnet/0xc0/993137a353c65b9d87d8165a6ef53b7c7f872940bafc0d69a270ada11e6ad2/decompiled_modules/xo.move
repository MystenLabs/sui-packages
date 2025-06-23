module 0xc0993137a353c65b9d87d8165a6ef53b7c7f872940bafc0d69a270ada11e6ad2::xo {
    struct XO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XO>(arg0, 8, b"XO", b"XOCIETY", b"XOCIETY is a POP Shooter with RPG progression.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/9e16f6bc-4bac-4dae-a0e4-f6e7e186a027.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XO>>(v1);
    }

    // decompiled from Move bytecode v6
}

