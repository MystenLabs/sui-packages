module 0x60bae256c55fb8c1acf0e0dae9010325d18798bb079e75adeea5d643dcb8b5ff::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"Coco", b"coco", b"my dog name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coco_27856e59b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

