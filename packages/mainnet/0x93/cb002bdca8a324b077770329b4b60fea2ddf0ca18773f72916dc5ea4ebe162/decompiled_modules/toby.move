module 0x93cb002bdca8a324b077770329b4b60fea2ddf0ca18773f72916dc5ea4ebe162::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBY>(arg0, 6, b"TOBY", b"TOBY SUI TOAD", b"toby the sui toad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5bc104e0_cc2e_4718_98dc_17f8e8e828c6_6dd8837dbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

