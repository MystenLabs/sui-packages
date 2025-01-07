module 0xc535fa383cfb16bdf9125c211d277cca612d32f68b07bb15ff7f040f3f1fb8e3::gat {
    struct GAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAT>(arg0, 6, b"Gat", b"Gostcat", b"Cute but not as cute as you think ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3847_f7b44ada00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

