module 0xcce5eeb04516a4f15a098c506bc874eeba9be50da3a1a71000b819c30235fcc::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"SHARK BEE", x"69276d206120536861726b204265652c666c792075702e20207468656e2073746f7020627920746f20746865207a6f6f202453420a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Guw_YPBN_3_400x400_a185592680.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

