module 0xca0945420e1ab4aa34869d18e6b37f1178bbb792a81f1eeff517497741247511::abl {
    struct ABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABL>(arg0, 9, b"ABL", b"Amir Bashi", b"Forfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42eced65-7ec2-4171-b05f-9e3937f5d113.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABL>>(v1);
    }

    // decompiled from Move bytecode v6
}

