module 0xf000e44a83db23b25db9fbad6d3513e39133f16e4b37283b56fe56b40ae416f6::cet {
    struct CET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CET>(arg0, 9, b"CET", b"Ceta", b"The meme coin that will bring tremendous growth to the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcdc900e-885f-41eb-b82d-c6fa9dffe2a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CET>>(v1);
    }

    // decompiled from Move bytecode v6
}

