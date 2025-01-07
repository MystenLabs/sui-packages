module 0xcc09896dafceb77d81469a89ce3269f2bbb9c7217b90e2ef7dc25b4540b86333::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G>(arg0, 6, b"G", b"H", b"B", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001475139.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

