module 0xd7df1fbb79969c3d736251053efe6479672e5e8517ce6e0d1ec7afd8a7ee52db::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"Posuidon", b"Posuidon, King of the Sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030393_dfc8d9ec70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

