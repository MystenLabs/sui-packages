module 0xed52b1c2176d46e8a52b1a6032bdfd3c2d00ecc37ff09d4a41f2cc418e8736d3::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"BLU SUI", b"In the depths of the SUI chain, a mysterious little being was born from pure blue energy. His name is BLU  a young chaotic guardian that carries a flame of unrealized force.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2025_05_06_T225843_491_d09059875f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

