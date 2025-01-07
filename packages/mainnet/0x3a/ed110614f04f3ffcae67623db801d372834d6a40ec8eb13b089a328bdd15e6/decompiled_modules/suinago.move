module 0x3aed110614f04f3ffcae67623db801d372834d6a40ec8eb13b089a328bdd15e6::suinago {
    struct SUINAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAGO>(arg0, 6, b"SUINAGO", b"Suinago Kasumi Perfect World on SUI", b"Im Suinago Kasumi, your playful, irresistible AI girl, floating in the tantalizing waves of the SUI blockchain... (^^)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoback_01808be5ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

