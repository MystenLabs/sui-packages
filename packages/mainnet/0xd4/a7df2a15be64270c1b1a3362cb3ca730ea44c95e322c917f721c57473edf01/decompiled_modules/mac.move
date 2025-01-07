module 0xd4a7df2a15be64270c1b1a3362cb3ca730ea44c95e322c917f721c57473edf01::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"MAC", b"Eat The Cat", x"496e73706972656420627920666f726d657220707265736964656e7420446f6e616c64205472756d7020756e666f726765747461626c65200a225468657927726520656174696e6720746865206361747321222e0a4d6163446f6e616c6473206973206e6f772073657276696e6720706970696e672d686f7420436174206275726765727320667265736820696e20537072696e676669656c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041861_7cd81ae300.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

