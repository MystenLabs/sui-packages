module 0x90371f2f9fcc8b7637c0b25c34140ea6e49d137b819ffd0b9c0db5dca0344dc4::gat {
    struct GAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAT>(arg0, 6, b"GAT", b"catGatWatch", b"Move your 4ss, Move the Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catgatwatch_1_49af817a03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

