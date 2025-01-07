module 0xbe67570ddbc7502366b300a6db241e6606375fb072f0c66355c20a5eaa944b96::alx {
    struct ALX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALX>(arg0, 9, b"ALX", b"Alex", b"Good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b54aa35-a183-42ab-b7f9-484c236d6f5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALX>>(v1);
    }

    // decompiled from Move bytecode v6
}

