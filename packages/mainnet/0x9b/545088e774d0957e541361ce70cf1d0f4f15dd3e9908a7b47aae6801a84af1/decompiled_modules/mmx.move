module 0x9b545088e774d0957e541361ce70cf1d0f4f15dd3e9908a7b47aae6801a84af1::mmx {
    struct MMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMX>(arg0, 6, b"MMX", b"Maga Matrix", b"Remember, the hat stays on. Join $MAGA army , enjoy the pump !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TORG_102_Front_61e6db5c96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

