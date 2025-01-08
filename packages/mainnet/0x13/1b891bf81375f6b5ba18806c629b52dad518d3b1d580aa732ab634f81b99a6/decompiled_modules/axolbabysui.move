module 0x131b891bf81375f6b5ba18806c629b52dad518d3b1d580aa732ab634f81b99a6::axolbabysui {
    struct AXOLBABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLBABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLBABYSUI>(arg0, 6, b"AXOLBABYSUI", b"Axol Baby Sui", b"Meet AXOLBABYSUI, the cutest amphibian! AXOL is more than just an adorable mascot it's a symbol of innovation in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/axol_37d525d811.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLBABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOLBABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

