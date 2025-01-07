module 0xfeb043c4b309be0ec088be69316236fc4d23a93b3f039b4a75fb453b949d1bf::marvel {
    struct MARVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVEL>(arg0, 9, b"MARVEL", b"Deadpool", b"Marvel Jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fd3f826-9f23-4565-8e56-1a57a24d9328.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

