module 0x9d9d759f8671b19ac6a053eb66d944052d061d1638a669d2d42ba24ef7d788d0::aib {
    struct AIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIB>(arg0, 6, b"AIB", b"America is Back", b"https://x.com/POTUS  has been updated and the cover photo is America is Back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737397338180.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

