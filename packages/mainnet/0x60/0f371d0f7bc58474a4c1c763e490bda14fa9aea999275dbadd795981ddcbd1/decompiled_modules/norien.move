module 0x600f371d0f7bc58474a4c1c763e490bda14fa9aea999275dbadd795981ddcbd1::norien {
    struct NORIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORIEN>(arg0, 9, b"NORIEN", b"Erlin", b"Norien meme is an inspiration from a great woman named Erlin Norien who struggled hard without relying on help from others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef531d72-be3f-49e5-a04f-561dfb86ba93-1000067523.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NORIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

