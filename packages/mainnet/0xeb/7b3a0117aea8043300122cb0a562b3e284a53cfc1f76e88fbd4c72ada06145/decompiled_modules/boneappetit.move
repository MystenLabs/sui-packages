module 0xeb7b3a0117aea8043300122cb0a562b3e284a53cfc1f76e88fbd4c72ada06145::boneappetit {
    struct BONEAPPETIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONEAPPETIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONEAPPETIT>(arg0, 6, b"BONEAPPETIT", b"Boneless Cat", b"Just a boneless cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Boneless_cat_2_f0e6f1133c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONEAPPETIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONEAPPETIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

