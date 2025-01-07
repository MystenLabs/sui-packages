module 0x134a0142d95596cabfcb250208294373a9ef4889dd97a590ccde81e40035f4cf::suitons {
    struct SUITONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITONS>(arg0, 6, b"SUITONS", b"SUITON", x"537569746f6e20686173206265656e2073756d6d6f6e6564210a746f2073746172742061206e65772073746f727920776974682074686520537569206c6567656e6420616e6420676976652061206c656761637920746f207468652053756920636f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Art_3a0563cf0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

