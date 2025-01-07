module 0x1f3d1e5636034ced87ddf3c453e275a5cde18c328511492a0917928d19237646::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"babypepe", b"babypepe", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

