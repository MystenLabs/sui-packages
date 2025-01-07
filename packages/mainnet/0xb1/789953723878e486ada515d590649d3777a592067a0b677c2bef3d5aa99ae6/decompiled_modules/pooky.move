module 0xb1789953723878e486ada515d590649d3777a592067a0b677c2bef3d5aa99ae6::pooky {
    struct POOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKY>(arg0, 6, b"POOKY", b"Sui Pooky", b"Run, $POOKY is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002555_131d11ee8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

