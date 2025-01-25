module 0x6510930c90353c5e4da628ddd68f346eb736eafc080069c34b128568d62a350e::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 6, b"SA", b"Sui Agent", b"game changer for DeFAI meme. help the community to push DeFAI into SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737815908574.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

