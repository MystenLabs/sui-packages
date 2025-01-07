module 0xa0236d6783562e0c6bf4f005e8faf7e659573200f9bffaea4744191651bbc2c::ogaarmy {
    struct OGAARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGAARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGAARMY>(arg0, 6, b"OGAARMY", b"Oga Army Sui", x"546865204f67612041726d792c20616e20696e646f6d697461626c6520666f726365206f66206c6974746c6520626c61636b206d6f6e73746572732c20686173206265656e20656e676167656420696e20612072656c656e746c65737320626174746c6520666f722079656172732c20616761696e7374204a6565747320616e64207363616d730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_200614_781_92579ccd57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGAARMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGAARMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

