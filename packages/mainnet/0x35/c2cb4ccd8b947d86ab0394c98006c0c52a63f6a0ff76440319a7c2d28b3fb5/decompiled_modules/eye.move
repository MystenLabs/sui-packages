module 0x35c2cb4ccd8b947d86ab0394c98006c0c52a63f6a0ff76440319a7c2d28b3fb5::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"Project Blue Eye", b"$EYE is an exclusive token unlocking access to a hidden ecosystem. Join the vision and claim your future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_Xp_Js_Ra_Tl_1737147825611_raw_9e117ffe02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

