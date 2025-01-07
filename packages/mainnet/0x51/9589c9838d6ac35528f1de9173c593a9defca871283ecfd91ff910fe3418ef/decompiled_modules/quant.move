module 0x519589c9838d6ac35528f1de9173c593a9defca871283ecfd91ff910fe3418ef::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"Quant", b"SuiQuant", x"446f6e7420525547206f7220576f726c6420576964652043544f2077696c6c20637275736820796f75210a4e4f20536f6369616c732c206e6f205255472c206e6f205363616d2c206a7573742050554d502e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_quant_6032158ba3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

