module 0x26428f41387e24b60dceaa1ff67a61cd7cf17fec7559e99188fc1db9d2fa475c::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 6, b"SUIC", b"Suichain", x"4c69666520697320746f6f20676f6f6420746f206265207374726573736564206f7574206f7665722063727970746f2e20417420535549434841494e2c207765277665206d6164652069742073696d706c652062790a7365616d6c6573736c7920696e746567726174696e672063727970746f20696e746f20796f7572206461696c7920726f7574696e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_CHAIN_ffbde719da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

