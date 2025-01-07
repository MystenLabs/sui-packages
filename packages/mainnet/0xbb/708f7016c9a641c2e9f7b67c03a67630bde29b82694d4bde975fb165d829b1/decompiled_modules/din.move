module 0xbb708f7016c9a641c2e9f7b67c03a67630bde29b82694d4bde975fb165d829b1::din {
    struct DIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIN>(arg0, 6, b"DIN", b"DIN PROJECT", b"THE DIN PROJECT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/din_991b895700.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

