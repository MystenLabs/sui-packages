module 0xf5db575782bd65beaafb36addbc514db7ba116c89b285331ba91d2901b6b5204::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"LOOPY SUI", x"46726f6d2074686520717569657420706f6e6473206f662074686520534f4c204e6574776f726b20746f2074686520627573746c696e67206369747920737472656574732c207468652053424f4d5059532068617665206c656674207468656972206d61726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ga_HU_At_Pz_400x400_fc3213c409.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

