module 0x12e83e5af94bb576c82752ecf8e4c935c92d3b45ac0e0d9e6ef29f9855f6ea8a::nth {
    struct NTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTH>(arg0, 6, b"NTH", b"Nothing_Sui", b"Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000279258_18f651045b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

