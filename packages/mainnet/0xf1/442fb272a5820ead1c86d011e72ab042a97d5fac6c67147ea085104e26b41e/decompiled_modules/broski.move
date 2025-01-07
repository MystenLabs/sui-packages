module 0xf1442fb272a5820ead1c86d011e72ab042a97d5fac6c67147ea085104e26b41e::broski {
    struct BROSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROSKI>(arg0, 6, b"BROSKI", b"FIRST BROSKI ON SUI", b"Broski is the one behind Pepe's success : https://broskionsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_29_e168f1ef85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

