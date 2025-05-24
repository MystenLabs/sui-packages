module 0x30c174af897d99a5b8adcff2c3c622e5d30864f4644b2e5897b31d6f2bb3cf03::apepe {
    struct APEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEPE>(arg0, 6, b"APEPE", b"Apepe", b"Pepe The Ape, has arrived to rally the warriors, swing through the chaos, and reclaim the jungle. No paper hands, no traitors. Only true degens. OOH OOH AH AH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apepelogo_e50e033dbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

