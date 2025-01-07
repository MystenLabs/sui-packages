module 0x52e88c3332c3a215dd3f65b09b261a7aabf3efcf3f5e1b512b03f9cca2f51d60::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 9, b"DB", b"Don't Buy", b"If you buy this, i Will donate to other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dec46c25-dd91-4808-b9d1-fee52b4f887e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

