module 0xd232708744129c68a9f90d2df303ae879b8df8101c780b9ae35e3d14865cd26f::liquorsui {
    struct LIQUORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUORSUI>(arg0, 6, b"LIQUORSUI", b"Liquor", b"Be water, be liquor, my friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_012547545_a43bbf81a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

