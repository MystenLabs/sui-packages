module 0xa3f6c95216df2ec21031fa9010ba6e39eea1317ea3288c556bff857caaee590c::chsui {
    struct CHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHSUI>(arg0, 6, b"CHSUI", b"Croc Hugging Sui", b"the first croc on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/croco_c97a7ac5f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

