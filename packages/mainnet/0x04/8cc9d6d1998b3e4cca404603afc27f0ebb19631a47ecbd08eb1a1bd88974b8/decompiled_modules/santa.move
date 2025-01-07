module 0x48cc9d6d1998b3e4cca404603afc27f0ebb19631a47ecbd08eb1a1bd88974b8::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 9, b"SANTA", b"SANTACLAUS", b"Meme Santa Claus is a very busy man, especially around Christmas time. He spends all year making toys for little boys and girls. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2834d7b6-7a78-49bd-ad6f-adf24fbf6fcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

