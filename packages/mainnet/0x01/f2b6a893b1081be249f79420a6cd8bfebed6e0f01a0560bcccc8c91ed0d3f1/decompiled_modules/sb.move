module 0x1f2b6a893b1081be249f79420a6cd8bfebed6e0f01a0560bcccc8c91ed0d3f1::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"SHARK BEE", x"69276d206120536861726b204265652c666c792075702e20207468656e2073746f7020627920746f20746865207a6f6f202453420a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Guw_YPBN_3_400x400_27b617b975.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

