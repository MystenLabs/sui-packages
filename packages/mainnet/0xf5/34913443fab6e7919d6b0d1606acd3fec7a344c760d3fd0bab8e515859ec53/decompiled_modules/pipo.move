module 0xf534913443fab6e7919d6b0d1606acd3fec7a344c760d3fd0bab8e515859ec53::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"PIPO COIN SUI", x"5369636b206f66207761746368696e67207075707069657320616e64206b697474656e73206d6f6e6f706f6c697a652074686520617474656e74696f6e3f0a0a546865726527732061206e657720686561767977656967687420696e20746865206d656d65206172656e612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_17_58_30_3829e559f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

