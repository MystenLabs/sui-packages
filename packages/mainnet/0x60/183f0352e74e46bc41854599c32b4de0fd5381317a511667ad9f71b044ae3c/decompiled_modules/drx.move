module 0x60183f0352e74e46bc41854599c32b4de0fd5381317a511667ad9f71b044ae3c::drx {
    struct DRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRX>(arg0, 9, b"DRX", b"DoctorX", b"Trending meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc671abe-5be8-4a50-ab36-7539725d6eb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

