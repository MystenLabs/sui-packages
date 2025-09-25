module 0xe1e715dcec9fc816a1fc189faf1c1665432821421aa3e96679e5e34796c1ac2d::kru {
    struct KRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRU>(arg0, 6, b"KRU", b"kuru", b"good project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758791747234.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

