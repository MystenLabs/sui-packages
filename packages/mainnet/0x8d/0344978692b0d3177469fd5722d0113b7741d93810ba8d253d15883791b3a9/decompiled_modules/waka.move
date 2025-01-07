module 0x8d0344978692b0d3177469fd5722d0113b7741d93810ba8d253d15883791b3a9::waka {
    struct WAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKA>(arg0, 6, b"WAKA", b"SHARKIRA", b"is coming to show off all its moves on the Sui network, let's shake it and do the waka waka together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_22_26_43_e47a60a6fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

