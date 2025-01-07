module 0x922343b13371738c1122049d3b1bc7f1b1533db58921699426b665b111924b5d::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 9, b"BTR", b"BornToRich", x"4a757374206d656d6520666f7220676f6f64206c69766520f09f9881", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfd67f15-803a-49cf-b9da-f83bbc87e0eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

