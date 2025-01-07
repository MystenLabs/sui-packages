module 0x185855bc84429aba2dd4333368ceae2a43e88a3dc1caa9d4ebb82e844299dd0b::vress {
    struct VRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRESS>(arg0, 6, b"VRESS", b"Vress", b"Vress the shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_5f17f10f62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

