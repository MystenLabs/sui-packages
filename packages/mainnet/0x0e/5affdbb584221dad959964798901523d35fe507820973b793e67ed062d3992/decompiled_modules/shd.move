module 0xe5affdbb584221dad959964798901523d35fe507820973b793e67ed062d3992::shd {
    struct SHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHD>(arg0, 9, b"SHD", b"Shadow", b"Meme token Shadow is an unusual token that hides all the mystery and mystery", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64662fac-0272-40b8-b1d9-6ccd7499a06b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

