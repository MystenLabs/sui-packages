module 0x9bd23488cc8a4ea089edd12fd2e33b84c39fb006270fa36f442f50ccc0940a6b::rbn {
    struct RBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBN>(arg0, 9, b"RBN", b"ROBEN", b"Pump our bags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2185e3a-cfb9-447e-a57a-28f8cbc1f41f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

