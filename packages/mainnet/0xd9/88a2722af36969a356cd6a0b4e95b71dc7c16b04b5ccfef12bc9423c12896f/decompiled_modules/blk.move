module 0xd988a2722af36969a356cd6a0b4e95b71dc7c16b04b5ccfef12bc9423c12896f::blk {
    struct BLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK>(arg0, 6, b"BLK", b"blekrok", b"BlackRock $BLK surpasses $11.5 trillion in assets under management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1424_96bb6ee33b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

