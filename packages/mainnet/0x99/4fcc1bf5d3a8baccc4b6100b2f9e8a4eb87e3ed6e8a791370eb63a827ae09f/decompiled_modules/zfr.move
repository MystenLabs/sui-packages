module 0x994fcc1bf5d3a8baccc4b6100b2f9e8a4eb87e3ed6e8a791370eb63a827ae09f::zfr {
    struct ZFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFR>(arg0, 9, b"ZFR", b"Zfr", b"New meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24b1f420-1131-4673-aee7-af333d8ac396.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

