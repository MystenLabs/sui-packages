module 0x8e1fa6383251849a4dd41da0df329274de65c2bd7a032bfb6f2b20373d392732::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"4669727374207375697363616e6e657220626f74206c697665200a0a405375695f5363616e6e65725f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027945_2d99fb9426.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

