module 0xff07ff590b9f46b0cd3374131e6222f06d6ebaeb37a2c2e8010bd276a7318e83::kwi {
    struct KWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWI>(arg0, 9, b"KWI", b"kiwi", x"6b697769206b69776920f09fa59df09f989c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7880dc37-f8a9-415b-a136-850ab3465f3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

