module 0xb9b790ac25e49f4d4c951d4993aaff47faab0271e89109508fe7b55fdd341f29::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"Chump The Chimp", b"A chimp on the sui chain. Exploring the depts and possibilities of current Tech. AI Agent token and NFT project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004481_40e676f1d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

