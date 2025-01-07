module 0x32295fe826112b4cdc68fc797442fd63aa1688a5a398dee072f6391c9da4b68e::gender {
    struct GENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENDER>(arg0, 9, b"GENDER", b"Gnd", b"The human gender ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f943d496-ebfb-48f8-ad5e-ad7684ebc06f-1000033252.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

