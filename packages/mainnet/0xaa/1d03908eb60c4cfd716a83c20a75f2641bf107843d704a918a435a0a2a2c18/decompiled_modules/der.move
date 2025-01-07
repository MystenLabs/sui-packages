module 0xaa1d03908eb60c4cfd716a83c20a75f2641bf107843d704a918a435a0a2a2c18::der {
    struct DER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DER>(arg0, 6, b"DER", b"Derivative", b"Derivative!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dohlwv_CW_4_A_Akctg_dee6cdcc68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DER>>(v1);
    }

    // decompiled from Move bytecode v6
}

