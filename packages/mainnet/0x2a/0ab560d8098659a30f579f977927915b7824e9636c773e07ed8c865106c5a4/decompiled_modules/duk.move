module 0x2a0ab560d8098659a30f579f977927915b7824e9636c773e07ed8c865106c5a4::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 9, b"DUK", b"Scream Duk", b"Just a screaming Duk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7599369a-1bf2-4beb-8a95-cac9a90af0ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

