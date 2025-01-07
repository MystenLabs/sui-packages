module 0x3d624c649824f2dce709b8482a4e886b763bac51f1213fb6bcedbf266a81b219::owlsn {
    struct OWLSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLSN>(arg0, 9, b"OWLSN", b"hensn", b"bend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8bf13d7-a1ee-4316-9985-379f2923cb01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWLSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

