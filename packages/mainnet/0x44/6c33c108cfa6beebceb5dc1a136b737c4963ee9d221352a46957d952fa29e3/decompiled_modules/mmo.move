module 0x446c33c108cfa6beebceb5dc1a136b737c4963ee9d221352a46957d952fa29e3::mmo {
    struct MMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMO>(arg0, 9, b"MMO", b"BonBon", b"Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31dca1d9-2008-4838-8d95-8576019b146d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

