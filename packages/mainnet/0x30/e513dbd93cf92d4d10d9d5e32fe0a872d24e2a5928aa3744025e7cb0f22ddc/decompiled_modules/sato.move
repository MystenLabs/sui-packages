module 0x30e513dbd93cf92d4d10d9d5e32fe0a872d24e2a5928aa3744025e7cb0f22ddc::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATO>(arg0, 6, b"SATO", b"SATO DEGEN", x"7361746f2c2074686520646567656e200a636174206f6620737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/amigo_estou_aqui_5_aa962a3bb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

