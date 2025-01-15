module 0xd2163757790b79fc51220824f7c620f9f22eebaa4385cde756b1c39e4233f64f::gai {
    struct GAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAI>(arg0, 6, b"GAI", b"GobAI", b"Accelerated by the sacred tree's energy, goblin intelligence and power surged, unleashing worldwide destruction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFPFIXXXXXXX_f8a6d32c60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

