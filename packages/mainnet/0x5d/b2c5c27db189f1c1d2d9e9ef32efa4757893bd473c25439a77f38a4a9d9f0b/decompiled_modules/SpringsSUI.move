module 0x5db2c5c27db189f1c1d2d9e9ef32efa4757893bd473c25439a77f38a4a9d9f0b::SpringsSUI {
    struct SPRINGSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRINGSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRINGSSUI>(arg0, 9, b"sysSUI", b"SY Spring Staked SUI", b"SY Spring Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPRINGSSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRINGSSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

