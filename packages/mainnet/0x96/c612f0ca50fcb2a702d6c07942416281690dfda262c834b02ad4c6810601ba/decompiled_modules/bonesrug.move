module 0x96c612f0ca50fcb2a702d6c07942416281690dfda262c834b02ad4c6810601ba::bonesrug {
    struct BONESRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONESRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONESRUG>(arg0, 6, b"BONESRUG", b"Bones Rug", x"426f6e657320527567206e2720436f6d70616e790a0a4120636f6d6d756e69747920737069746520746f6b656e20746f20686176652066756e207768696c65207765207761697420666f7220486f7046756e20706861736520332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonesrug_4fcf0d7205.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONESRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONESRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

