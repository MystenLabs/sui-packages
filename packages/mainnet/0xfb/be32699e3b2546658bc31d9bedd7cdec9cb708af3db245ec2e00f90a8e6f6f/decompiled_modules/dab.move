module 0xfbbe32699e3b2546658bc31d9bedd7cdec9cb708af3db245ec2e00f90a8e6f6f::dab {
    struct DAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAB>(arg0, 6, b"DAB", b"Devs Are Bad", b"Devs are bad, lets see how far a coin with nothing can go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731449893138.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

