module 0x7481b7e7c000c04d4b36e5c2f15c4b98a319ce166ec76fe3ca6b7b7adb5caa5b::cw {
    struct CW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CW>(arg0, 9, b"CW", b"CatWawe ", b"Cat wawe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31d2a112-de61-4a66-bb2e-e6f8e369b2f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CW>>(v1);
    }

    // decompiled from Move bytecode v6
}

