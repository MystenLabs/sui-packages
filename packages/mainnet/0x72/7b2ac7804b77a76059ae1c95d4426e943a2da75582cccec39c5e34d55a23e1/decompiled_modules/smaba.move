module 0x727b2ac7804b77a76059ae1c95d4426e943a2da75582cccec39c5e34d55a23e1::smaba {
    struct SMABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMABA>(arg0, 6, b"SMABA", b"SuiMABA", b"Make America Based Again on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0526_d2d3797b6e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

