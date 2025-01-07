module 0xebd8b7f16301253a775caaa6db61fa9e6ba5738e4b79df3b6451317197e94a77::loulou {
    struct LOULOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOULOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOULOU>(arg0, 6, b"LOULOU", b"LOULOU on SUI", b" A Dutch pug spreading smiles all over the world !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_OX_Qafzt_400x400_187afce794.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOULOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOULOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

