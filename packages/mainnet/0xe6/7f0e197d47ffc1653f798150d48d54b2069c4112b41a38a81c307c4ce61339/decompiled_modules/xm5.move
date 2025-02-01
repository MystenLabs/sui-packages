module 0xe67f0e197d47ffc1653f798150d48d54b2069c4112b41a38a81c307c4ce61339::xm5 {
    struct XM5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XM5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XM5>(arg0, 6, b"XM5", b"X Money Sui", x"58204d6f6e65792053756920697320612073706563756c617469766520746f6b656e20666f72207468652053756920636f6d6d756e6974792e0a0a4120706f7274696f6e206f662074686520737570706c792077696c6c2062652064656469636174656420746f206c697374696e677320616e64206d61726b6574696e672c20616c7761797320776974682066756c6c207472616e73706172656e637920616e64206120666f637573206f6e20636f6d6d756e6974792067726f7774682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738414459547.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XM5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XM5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

