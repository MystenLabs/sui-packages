module 0x5192e8aef069842b77f87d7f73078cc842c5585cbfd4499fd040c1e094e2b2f2::snpr {
    struct SNPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNPR>(arg0, 6, b"SNPR", b"OctSnipr", x"465249444159205448452031335448204953204a5553542054484520424547494e4e494e47200a0a416e6420626577617265206f6620736e6970657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_23_36_22_4464533203.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

