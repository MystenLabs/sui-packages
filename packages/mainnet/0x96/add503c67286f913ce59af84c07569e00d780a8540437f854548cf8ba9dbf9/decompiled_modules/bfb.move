module 0x96add503c67286f913ce59af84c07569e00d780a8540437f854548cf8ba9dbf9::bfb {
    struct BFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFB>(arg0, 9, b"BFB", b"DGS", b"VSV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c2a32b1-9cb4-4ed1-921f-c03b8287f5a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

