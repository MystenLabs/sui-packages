module 0x6f2990a8d0a3e782ac90a4d7b977396194318e07cb8d1e8a0aefb7caca092230::apez {
    struct APEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEZ>(arg0, 9, b"APEZ", b"apee", b"PEZZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf73e986-9087-42f6-a98e-3374bdaca3b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

