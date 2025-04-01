module 0xd51ad4a496cc37fb361133944706cd515c5201c8d48d559d18a821f5e11af8aa::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 6, b"CAPO", b"CAPOO", b"Capoo looks like a cat and bug also has six feet and loves meat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/183_E426_C_CCCA_4_B1_A_852_F_5_E632_EE_1_B59_F_5e8755f1c5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

