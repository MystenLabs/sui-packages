module 0xded67baa5408849ceac6cb3f23f7b0f6f130a3823eb300403ae3523eff306260::sef {
    struct SEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEF>(arg0, 9, b"SEF", b"Seerafim", b"The most common rr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/052076b6-3157-40cc-8ae6-b579302b5adb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

