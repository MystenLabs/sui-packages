module 0x269873fb4948ddbb14e3e31216f4b031fa4e1d3decb362be51e88e74bb252856::xa {
    struct XA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XA>(arg0, 9, b"XA", b"Xaxa", b"Like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0594eb88-87f2-4ffb-bf2c-f5d496e5b3a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XA>>(v1);
    }

    // decompiled from Move bytecode v6
}

