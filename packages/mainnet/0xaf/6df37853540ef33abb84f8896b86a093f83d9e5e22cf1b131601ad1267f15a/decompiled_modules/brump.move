module 0xaf6df37853540ef33abb84f8896b86a093f83d9e5e22cf1b131601ad1267f15a::brump {
    struct BRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUMP>(arg0, 6, b"BRUMP", b"Brett Trump Sui", x"4f4e45204f462043525950544f53204d4f5354205349474e49464943414e542043554c545552414c2049434f4e5320414e4420544845204d4153434f54204f462053554920434841494e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001845_56657fc394.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

