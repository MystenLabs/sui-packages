module 0x348eb2322209b8a749a957efb5f67ccdd22ac97977214554051872b0f61cdbee::mum {
    struct MUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUM>(arg0, 6, b"MUM", b"Elon's mum", b"the most important person in his life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/licensed_image_59d01e0f08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

