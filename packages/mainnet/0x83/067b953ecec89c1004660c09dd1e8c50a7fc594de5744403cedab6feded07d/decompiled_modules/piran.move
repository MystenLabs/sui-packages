module 0x83067b953ecec89c1004660c09dd1e8c50a7fc594de5744403cedab6feded07d::piran {
    struct PIRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRAN>(arg0, 9, b"PIRAN", b"Piran Hypeee", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b32715287d24ee98c39589b37cde4c98blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

