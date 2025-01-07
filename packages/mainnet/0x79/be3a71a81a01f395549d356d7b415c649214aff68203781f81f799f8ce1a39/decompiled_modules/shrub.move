module 0x79be3a71a81a01f395549d356d7b415c649214aff68203781f81f799f8ce1a39::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUB>(arg0, 6, b"SHRUB", b"The Hedgehog on Sui", b"$Shrub is a community-managed project representing Elon's pet hedgehog. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_7526540023.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

