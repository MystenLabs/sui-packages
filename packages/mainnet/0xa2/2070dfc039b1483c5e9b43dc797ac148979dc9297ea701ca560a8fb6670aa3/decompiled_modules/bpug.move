module 0xa22070dfc039b1483c5e9b43dc797ac148979dc9297ea701ca560a8fb6670aa3::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"Baby Pug", x"4c61756e6368696e67206f6e20547572626f732e66756e20736f6f6e210a0a20426f726e2066726f6d20746865204f472c2046756420746865205075672c20244250554720697320726561647920746f20737465616c207468652073706f746c69676874206f6e2053756921205769746820697473206375746520627574206d697363686965766f757320636861726d2c204261627920507567206973206865726520746f206261726b206974732077617920746f2074686520746f702c2077616767696e67207461696c7320616e642077696e6e696e672068656172747320616c6f6e6720746865207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_01_9e3c62672c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

