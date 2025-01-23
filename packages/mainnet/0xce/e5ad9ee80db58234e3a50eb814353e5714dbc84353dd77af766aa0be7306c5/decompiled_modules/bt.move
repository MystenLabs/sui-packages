module 0xcee5ad9ee80db58234e3a50eb814353e5714dbc84353dd77af766aa0be7306c5::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 6, b"BT", b"Barron Trump", b"The future leader of the free world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Barron_Trump_8a58543993.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BT>>(v1);
    }

    // decompiled from Move bytecode v6
}

