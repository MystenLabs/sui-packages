module 0x2edbce62150f950ae8bb2e8dda020280e32553e550f13f9dcafe29a2c391aa1b::idng {
    struct IDNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDNG>(arg0, 9, b"IDNG", b"IDNGold (Testnet)", b"Test IDNG for GoldVault testnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IDNG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IDNG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

