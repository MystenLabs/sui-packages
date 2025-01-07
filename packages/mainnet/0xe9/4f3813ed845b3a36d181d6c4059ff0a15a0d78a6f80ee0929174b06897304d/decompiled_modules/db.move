module 0xe94f3813ed845b3a36d181d6c4059ff0a15a0d78a6f80ee0929174b06897304d::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 9, b"DB", b"Don't Buy", b"If you buy this, i Will donate to other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/056da139-11d8-47ad-8cf7-597b75194e3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

