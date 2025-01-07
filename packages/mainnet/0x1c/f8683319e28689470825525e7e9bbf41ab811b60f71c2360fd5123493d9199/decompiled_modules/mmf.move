module 0x1cf8683319e28689470825525e7e9bbf41ab811b60f71c2360fd5123493d9199::mmf {
    struct MMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMF>(arg0, 9, b"MMF", b"Memefi", b"MMF, Memefi, mmf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6398cc5b-e8e6-4576-b950-0c59b363a1c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

