module 0x2d66fab8882fbc29a6401edb945d9540d323aa772225605ecad9855393d6194f::Im_Ok {
    struct IM_OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IM_OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IM_OK>(arg0, 9, b"OK", b"Im Ok", b"it's going to be ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz4w3L2XYAAfOf6?format=jpg&name=240x240")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IM_OK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IM_OK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

