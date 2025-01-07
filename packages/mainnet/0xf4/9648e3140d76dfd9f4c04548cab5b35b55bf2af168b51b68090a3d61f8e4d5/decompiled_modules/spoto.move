module 0xf49648e3140d76dfd9f4c04548cab5b35b55bf2af168b51b68090a3d61f8e4d5::spoto {
    struct SPOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTO>(arg0, 6, b"SPOTO", b"SUPER OTTO", b"The best proyect have the best developers and we are the team of marketing, we thing the dogs will return, xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730559576146.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

