module 0xa2b872347d4be5ad4c892cb135cc11ea45728691380e4193f71c56afc7876bef::goldseal {
    struct GOLDSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDSEAL>(arg0, 6, b"GOLDSEAL", b"Golden seal", b"Golden seal is created from the bottom of the sea from treasure heading towards the moons", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/50fdd48d_28af_47cc_bb03_a63028f933d9_d27918c911.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDSEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDSEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

