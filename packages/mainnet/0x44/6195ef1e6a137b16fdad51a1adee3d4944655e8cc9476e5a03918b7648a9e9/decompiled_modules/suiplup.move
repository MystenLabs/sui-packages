module 0x446195ef1e6a137b16fdad51a1adee3d4944655e8cc9476e5a03918b7648a9e9::suiplup {
    struct SUIPLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLUP>(arg0, 6, b"SUIPLUP", b"PLUP PENGUIN", x"546865206d6f7374206375746520776174657220706f6b656d6f6e206973206e6f77206f6e2024535549200a0a2054473a68747470733a2f2f742e6d652f5375695f706c75700a0a205765623a20537569506c75702e636f6d0a0a3a2068747470733a2f2f782e636f6d2f737569706c7570", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3618_fc21c32c58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

