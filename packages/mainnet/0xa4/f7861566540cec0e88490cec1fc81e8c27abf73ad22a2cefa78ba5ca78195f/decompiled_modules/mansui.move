module 0xa4f7861566540cec0e88490cec1fc81e8c27abf73ad22a2cefa78ba5ca78195f::mansui {
    struct MANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANSUI>(arg0, 6, b"MANSUI", b"MANATEE SUI", x"446f6e277420666f7267657420746f206272696e672061204d616e6174656520210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_24_29_d5226e079a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

