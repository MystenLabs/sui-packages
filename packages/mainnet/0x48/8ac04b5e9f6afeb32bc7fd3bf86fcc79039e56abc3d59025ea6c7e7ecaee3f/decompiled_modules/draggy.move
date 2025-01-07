module 0x488ac04b5e9f6afeb32bc7fd3bf86fcc79039e56abc3d59025ea6c7e7ecaee3f::draggy {
    struct DRAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGGY>(arg0, 6, b"DRAGGY", b"DRAGGY SUI", b"DRAGGY So much more than just a memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd12a99dbc40036cec6f1b776dccd2d36f5953b94_060ab869e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

