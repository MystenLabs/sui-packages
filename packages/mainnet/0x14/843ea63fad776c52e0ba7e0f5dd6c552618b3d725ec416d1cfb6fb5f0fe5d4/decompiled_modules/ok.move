module 0x14843ea63fad776c52e0ba7e0f5dd6c552618b3d725ec416d1cfb6fb5f0fe5d4::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OK>(arg0, 6, b"OK", b"ok - sui", b"ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fb3aa9893a0172aea1fa9b7eae5310ba_278ead92e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

