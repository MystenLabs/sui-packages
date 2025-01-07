module 0xfaaa22cfea1fdc84d3aec652a0112e76fc1b5653094e6b4da96946df135969f9::trenchy {
    struct TRENCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHY>(arg0, 6, b"TRENCHY", b"Trenchy", x"4f70656e206d61726b657420666f722063727970746f2073657276696365732c207468696e6b2066697665722062757420666f72207472656e63686572730a0a4265636f6d652061205472656e63682057617272696f7220546f6461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734361047801.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRENCHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

