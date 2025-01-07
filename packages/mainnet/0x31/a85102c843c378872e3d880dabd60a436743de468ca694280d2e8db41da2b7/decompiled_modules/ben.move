module 0x31a85102c843c378872e3d880dabd60a436743de468ca694280d2e8db41da2b7::ben {
    struct BEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEN>(arg0, 6, b"ben", b"ben", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

