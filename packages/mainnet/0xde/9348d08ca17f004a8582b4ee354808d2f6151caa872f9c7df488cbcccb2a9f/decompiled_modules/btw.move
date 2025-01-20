module 0xde9348d08ca17f004a8582b4ee354808d2f6151caa872f9c7df488cbcccb2a9f::btw {
    struct BTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTW>(arg0, 6, b"BTW", b"Banana Trump Wall", b"Make America Ripe Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_052230_396_24b3eef4de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

