module 0xdc81d9c593794b12048d4cc0a3fd9525e782d80ef8e551328c9e7770ca2b70fa::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"APOC", b"Rad", b"Safe World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2055a3d-3bd9-43d5-922a-00dc0139e0fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

