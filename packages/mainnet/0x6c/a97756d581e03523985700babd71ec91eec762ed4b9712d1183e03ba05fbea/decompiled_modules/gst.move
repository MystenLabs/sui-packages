module 0x6ca97756d581e03523985700babd71ec91eec762ed4b9712d1183e03ba05fbea::gst {
    struct GST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GST>(arg0, 6, b"GST", b"Gangster", b"Between trust and betrayal, the gangster walks on in style today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/063eb233_bf7d_4da0_b31c_c9eb78e60eaa_2e9faef50c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GST>>(v1);
    }

    // decompiled from Move bytecode v6
}

