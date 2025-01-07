module 0x6586081c57049d53c52179f43c326156d7f5b6bf3af6019c972a050aea6e7dfa::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"AAA", b"ABC", b"sfasfasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file.walletapp.waveonsui.com/images/wave-pumps/8fd4a496-1827-4b1f-812f-e073607697f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

