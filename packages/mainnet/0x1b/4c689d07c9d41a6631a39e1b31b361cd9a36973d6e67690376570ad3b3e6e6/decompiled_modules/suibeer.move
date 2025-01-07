module 0x1b4c689d07c9d41a6631a39e1b31b361cd9a36973d6e67690376570ad3b3e6e6::suibeer {
    struct SUIBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEER>(arg0, 6, b"SuiBEER", b"Sui BEER", x"5468697320697320746865206669727374206d656d652062726577657279206f6e2024535549200a4a6f696e2074686520747261696e206e6f77206c657473206d616b65206d6f72652024424545525321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VW_Uj_Umkr_400x400_4e1425aeb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

