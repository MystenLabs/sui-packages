module 0xc85014c3db3d3b0e6d1740d5a633cde4d5498c980dec0a6f78cf5ac931972ab4::suikamala {
    struct SUIKAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKAMALA>(arg0, 9, b"SUIKAMALA", b"SUI KAMALA", x"4b414d414c4120484152524953203d205553203120f09f87baf09f87b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c047c591-8e4d-49bb-8042-1d3d95b02d1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

