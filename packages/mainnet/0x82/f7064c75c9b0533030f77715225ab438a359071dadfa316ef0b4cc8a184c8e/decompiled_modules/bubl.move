module 0x82f7064c75c9b0533030f77715225ab438a359071dadfa316ef0b4cc8a184c8e::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"Bubble On Sui", x"244255424c2047554d0a627562626c65732061726520657665727977686572652077617465722069732c20616e6420537569206973206e6f20657863657074696f6e2e20546865792070756d702c20666c6f61742c20616e6420626f696c2020746865792772652066756e2e205375692069732077617465722c207761746572206e65656473204255424c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037492_ff2ecb5b4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

