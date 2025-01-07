module 0x4f9500a9e3f1f8e26942006560ca322bd443d1e143d3fc1734ae7b203b8d79e1::assasin {
    struct ASSASIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSASIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSASIN>(arg0, 6, b"ASSASIN", b"Assisin", b"Templar Assasin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/leyr1112_d64bbac381.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSASIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSASIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

