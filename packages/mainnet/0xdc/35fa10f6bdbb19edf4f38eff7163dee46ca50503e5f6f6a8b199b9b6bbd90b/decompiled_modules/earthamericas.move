module 0xdc35fa10f6bdbb19edf4f38eff7163dee46ca50503e5f6f6a8b199b9b6bbd90b::earthamericas {
    struct EARTHAMERICAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTHAMERICAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EARTHAMERICAS>(arg0, 6, b"EARTHAMERICAS", b"EARTH GLOBE AMERICAS", b"SuiEmoji Earth Globe Americas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/earthamericas.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EARTHAMERICAS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTHAMERICAS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

