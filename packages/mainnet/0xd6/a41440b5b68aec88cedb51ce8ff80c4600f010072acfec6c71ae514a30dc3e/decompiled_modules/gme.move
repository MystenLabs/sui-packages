module 0xd6a41440b5b68aec88cedb51ce8ff80c4600f010072acfec6c71ae514a30dc3e::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"Game Stop SUI", b"Home of the Degens of Wall Street", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734989345519.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

