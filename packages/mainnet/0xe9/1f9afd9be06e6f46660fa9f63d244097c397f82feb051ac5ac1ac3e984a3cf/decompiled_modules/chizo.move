module 0xe91f9afd9be06e6f46660fa9f63d244097c397f82feb051ac5ac1ac3e984a3cf::chizo {
    struct CHIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIZO>(arg0, 6, b"CHIZO", b"CHIZO SUI", x"4e6576612073746f7020666974652c206576656e206966206d616e676f2073637265616d206269670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vh_I9f_5_Y_400x400_c662fc7b66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

