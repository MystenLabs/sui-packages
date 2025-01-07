module 0xfaca7c05751fd7ea85a20b44fbacb6beb23d7a377f9ffd49456a2f3156d47ef4::dogememe {
    struct DOGEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEMEME>(arg0, 9, b"DOGEMEME", b"Dogeton", b"So wonderfull, congratulation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e74848bf-9cfb-4c6e-b2f2-d97442b05647.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

