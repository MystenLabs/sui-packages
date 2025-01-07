module 0xd4134e9a5a864702bac22f0f2b7d5ab826cf11d0d4b6b3a96dff18ce2bf86fe5::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"DROP", b"Dropper", b"Just drop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae330b58_5f0a_4eb8_ac19_9719d0fa0721_1_cdad60d25a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

