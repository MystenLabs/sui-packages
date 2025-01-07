module 0x9d7f9faddfafcdf637b66ba385008863727356d1f84679fe0187c74fdb83b6b1::catpaw {
    struct CATPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPAW>(arg0, 9, b"CATPAW", b"Cats", b"Cat paws is a good community token with strong backup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b49db57f-283c-4bb9-b60c-278fd13ecc2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

