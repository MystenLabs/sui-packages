module 0x1b568fa27bc7aef7ba0321caf4461f9110a6205fa2602c87549dfe5583779c48::gui {
    struct GUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUI>(arg0, 6, b"GUI", b"GUI INU", b"$GUI INU is the #1 community token on SUI. Made by the community, for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hgc_D_Mf8_N_400x400_64b9a85842.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

