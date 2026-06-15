module 0xa672389b7b73df60d40666ac9545433d59d3128086b9e3a425a66bbffdf4dc5::susn {
    struct SUSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSN>(arg0, 6, b"sUSN", b"Staked USN", b"Sui LayerZero OFT representation of Noon's staked USN (sUSN).", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

