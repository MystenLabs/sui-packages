module 0x889ddd680c94849d292df54203e3cca2d769d8777b0a6268b56faf00aa16a4a7::sprungsui {
    struct SPRUNGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRUNGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRUNGSUI>(arg0, 9, b"", b"Staked SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRUNGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRUNGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

