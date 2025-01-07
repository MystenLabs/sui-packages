module 0x65ce92aea764b4ed35464444cd998c93017bb85ca17a814d9d5f60662b02d862::brb {
    struct BRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRB>(arg0, 6, b"Brb", b"BRB", b"Brb is meme token on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_a238eb82d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

