module 0xe165f7c46f0380154f084ba095e921629f0cf92a74010879a8259593a073aa9f::rjd {
    struct RJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RJD>(arg0, 9, b"RJD", b"Cadences ", b"Xjdj I love you so much and ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe0eb68c-7fcb-4b95-8235-875122301660.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

