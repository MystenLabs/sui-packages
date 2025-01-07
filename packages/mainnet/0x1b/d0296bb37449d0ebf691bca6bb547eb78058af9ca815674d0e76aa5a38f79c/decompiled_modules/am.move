module 0x1bd0296bb37449d0ebf691bca6bb547eb78058af9ca815674d0e76aa5a38f79c::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 9, b"AM", b"American", b"American forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3395f70-6cd0-4ad9-ab2b-fa6806d7e40e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

