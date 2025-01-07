module 0xbe871cea56b8fa0fab6e9f17185c663f85e680bfe8403c0e8909b280be6b7596::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"OWL ON SUI", x"224f776c204f4e205355493a20576865726520736d6172740a6f776c73206d6565742122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_LW_Vuh2n_400x400_ef43cca4c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

