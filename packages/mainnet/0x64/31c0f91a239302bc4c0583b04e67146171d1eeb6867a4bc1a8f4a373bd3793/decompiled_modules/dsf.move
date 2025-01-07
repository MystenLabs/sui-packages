module 0x6431c0f91a239302bc4c0583b04e67146171d1eeb6867a4bc1a8f4a373bd3793::dsf {
    struct DSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSF>(arg0, 6, b"DSF", b"DOGE SUI FLOW", b"The unique and real SUI DOGE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_350543610b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

