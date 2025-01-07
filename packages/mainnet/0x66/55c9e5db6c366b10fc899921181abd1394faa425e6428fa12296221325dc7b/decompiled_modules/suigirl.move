module 0x6655c9e5db6c366b10fc899921181abd1394faa425e6428fa12296221325dc7b::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 6, b"SUIGIRL", b"SUIGIRLS", b"SUIGIRL IS NEXT SUIMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuplikan_layar_2024_10_11_163736_a781d92f39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

