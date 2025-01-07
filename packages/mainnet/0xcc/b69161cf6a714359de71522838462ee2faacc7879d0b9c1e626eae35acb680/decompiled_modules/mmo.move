module 0xccb69161cf6a714359de71522838462ee2faacc7879d0b9c1e626eae35acb680::mmo {
    struct MMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMO>(arg0, 9, b"MMO", b"mountain", b"powerful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd40444a-759b-462c-8c40-8028c0f46687.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

