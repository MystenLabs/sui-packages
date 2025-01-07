module 0x535b78c70e6bc9d0720bb179c49b886ff21d6c02de0e4d844f19cd2a3ff36d46::combo {
    struct COMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMBO>(arg0, 6, b"COMBO", b"Combo Breaker", x"46697273742065766572206d656d6520746f20617070656172206f6e20616e7920626c6f636b636861696e2e200a372f382f323031312031353a32383a3131", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5957_6b0aced4dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

