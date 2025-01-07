module 0xd969157f66032239ce3137e45b6c671b74d1c529048b802c014decb758d09afa::aadog {
    struct AADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AADOG>(arg0, 9, b"AADOG", b"Sangdogs", b"Adogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e330bbea-34ee-4bec-b75b-3cb4465cdb3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

