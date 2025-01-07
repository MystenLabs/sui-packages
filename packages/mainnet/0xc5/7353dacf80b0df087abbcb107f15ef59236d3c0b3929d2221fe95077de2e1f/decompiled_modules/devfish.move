module 0xc57353dacf80b0df087abbcb107f15ef59236d3c0b3929d2221fe95077de2e1f::devfish {
    struct DEVFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVFISH>(arg0, 6, b"DEVFISH", b"Dev is a Fish", x"544845204445562049532041204649534820286c69746572616c6c7929202068747470733a2f2f742e6d652f446576497343544f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dev_is_a_Fish2_2a782fe516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

