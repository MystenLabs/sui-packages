module 0x357b5187f800fdc2811b22f480c9172843ab8d84b036fa9920309482ccc54cfb::tmm {
    struct TMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMM>(arg0, 9, b"TMM", b"Twin Mount", b"Like two strong brothers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa58598d-2d2e-4025-b11f-d01ba9e81852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

