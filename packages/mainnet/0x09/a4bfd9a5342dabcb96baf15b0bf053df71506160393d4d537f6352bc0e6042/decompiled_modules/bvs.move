module 0x9a4bfd9a5342dabcb96baf15b0bf053df71506160393d4d537f6352bc0e6042::bvs {
    struct BVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVS>(arg0, 6, b"BVS", b"Bloo vs Sui", b"This is a memecoin that related to different chains just buy and hold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1634_ba5dfe6bda.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

