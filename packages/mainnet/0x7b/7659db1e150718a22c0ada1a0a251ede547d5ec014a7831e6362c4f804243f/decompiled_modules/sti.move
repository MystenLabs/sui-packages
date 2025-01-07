module 0x7b7659db1e150718a22c0ada1a0a251ede547d5ec014a7831e6362c4f804243f::sti {
    struct STI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STI>(arg0, 6, b"STI", b"Stitch", x"4920776173206372656174656420746f206d616b6520746865205375692065636f73797374656d206d6f72652062656175746966756c2e0a42757420646f6e277420666f726765742c20537469746368206973207665727920706f77657266756c2e204d6179626520492063616e20737572707269736520796f752e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024364_bc3aeb7887.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STI>>(v1);
    }

    // decompiled from Move bytecode v6
}

