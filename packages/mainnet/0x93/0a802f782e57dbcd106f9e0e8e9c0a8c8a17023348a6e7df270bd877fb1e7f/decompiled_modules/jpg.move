module 0x930a802f782e57dbcd106f9e0e8e9c0a8c8a17023348a6e7df270bd877fb1e7f::jpg {
    struct JPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPG>(arg0, 9, b"JPG", b"Dsf", b"Nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76b1342e-f2fd-411c-a934-68c338f2eeff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

