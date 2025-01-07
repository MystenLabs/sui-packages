module 0x70c952c1037e0b52645bf18d23500683b31753e1c9eb151f5659e3a682d228f5::sob {
    struct SOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOB>(arg0, 6, b"SOB", b"Sui On  Bull", x"2442756c6c27697368206f6e20746865200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibul_caeb9ae61d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

