module 0x2394a220a01058231357f376ddd4b93f8c700f270ab74cd1b7b4c6a8c20fb9c::castle {
    struct CASTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTLE>(arg0, 6, b"CASTLE", b"Sand Castle", b"Standing tall on the shores of the Sui Network, $SANDCASTLE is built from grit and dreams.  It may be made of sand, but its a symbol of strengthweathering the tides and making its mark on the coast of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sand_Castle_853082e3c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

