module 0xf1a74060590166a1e9965ed606f94fbd0a76d5cb19acbcea759dcc55ef373b5e::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"CHUMP SUI", b"Chump Sui a blue cartoon blob character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6v475qr6gntevw7pbi55ijaelu3zbb4k7rihtvtk56lcpxqendq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

