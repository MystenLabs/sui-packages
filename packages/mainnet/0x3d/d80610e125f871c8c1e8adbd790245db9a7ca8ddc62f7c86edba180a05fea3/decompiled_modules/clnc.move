module 0x3dd80610e125f871c8c1e8adbd790245db9a7ca8ddc62f7c86edba180a05fea3::clnc {
    struct CLNC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLNC>, arg1: 0x2::coin::Coin<CLNC>) {
        0x2::coin::burn<CLNC>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLNC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CLNC>>(0x2::coin::mint<CLNC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CLNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLNC>(arg0, 6, b"$CLNC", b"CLNC", b"utility token for Clan Circle", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLNC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLNC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

