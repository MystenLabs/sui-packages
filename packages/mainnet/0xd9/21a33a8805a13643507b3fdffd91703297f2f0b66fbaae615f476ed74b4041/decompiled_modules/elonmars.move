module 0xd921a33a8805a13643507b3fdffd91703297f2f0b66fbaae615f476ed74b4041::elonmars {
    struct ELONMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMARS>(arg0, 9, b"ELONMARS", b"ELON MARS", x"454c4f4e4d41525320e2809320412073706163652063727970746f20696e737069726564206279204d617273206578706c6f726174696f6e2e204675656c656420627920696e6e6f766174696f6e20616e6420616d626974696f6e2c206974e280997320746865206675747572652063757272656e637920666f722070696f6e656572732e204a6f696e20746865206d697373696f6e20616e64207368617065207468652066697273742052656420506c616e65742065636f6e6f6d79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a1e9df9-8f6d-4386-a368-5c19977b7caf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

