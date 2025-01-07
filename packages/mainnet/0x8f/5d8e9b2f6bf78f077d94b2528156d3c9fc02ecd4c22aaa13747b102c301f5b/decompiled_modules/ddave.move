module 0x8f5d8e9b2f6bf78f077d94b2528156d3c9fc02ecd4c22aaa13747b102c301f5b::ddave {
    struct DDAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDAVE>(arg0, 6, b"DDAVE", b"Degen Dave", b"Welcome to the $DDAVE era! The next X1000 gem on $SUI you'll surely miss out on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_16_12_54_11_f9cbefdc5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

