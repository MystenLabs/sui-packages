module 0xde215ad0da35412801c3953aa9e0ddd04128af8fd7c0a18bce4321d140988aa9::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"XRPSUI ", b"Token meme Xrp Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27241fa4-8512-4c30-b8ab-8abfe02a49c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

