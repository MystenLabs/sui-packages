module 0x7c392070e158535b25023f6e3dab0f40fba26966fee5e237c8d57448e9bc9bcf::goo {
    struct GOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOO>(arg0, 6, b"GOO", b"Sui Gooey", b"Post-nut clarity: on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/what_message_do_you_think_anno_was_trying_to_send_with_v0_z7f695f4s11b1_ba013b938e.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

