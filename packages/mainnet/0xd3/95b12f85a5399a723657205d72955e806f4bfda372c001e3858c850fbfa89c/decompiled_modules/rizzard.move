module 0xd395b12f85a5399a723657205d72955e806f4bfda372c001e3858c850fbfa89c::rizzard {
    struct RIZZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZARD>(arg0, 6, b"RIZZARD", b"Rizzard On Sui", x"776974686f75742068756d616e6974792c20746865726520617265206e6f206d616368696e65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_080947_960_95dbfede2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

