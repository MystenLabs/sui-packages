module 0xa07955d5d6987212661c5c9aef901445942c004da1faa648eaed7bb37a04c836::stn {
    struct STN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STN>(arg0, 9, b"STN", b"Saturn", b"we fly much more than moon we want to fly to saturn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6420bae-100d-4486-a048-2d23108d32ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STN>>(v1);
    }

    // decompiled from Move bytecode v6
}

