module 0xeab68ebf16bf786175d5c2ccedd719fb36ba851c2028106e85f976e134905db1::penbd {
    struct PENBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBD>(arg0, 9, b"PENBD", b"jskan", b"gsnwb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/905b8024-4473-4491-9586-d4b69f7e23ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

