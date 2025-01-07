module 0xf575c676692f2fee5ce3ac246037903f2c54fa9244685faf661f4a42ed2ba0d0::dib {
    struct DIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIB>(arg0, 6, b"DIB", b"Dev Is Burn", b"Dev Will Burn all token step by step", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004541_2970160164.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

