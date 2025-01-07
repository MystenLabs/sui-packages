module 0x165e3315049973604d187a7c893e83432b9ce7828b3eb312ec9d3c6984c975e0::ps {
    struct PS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS>(arg0, 6, b"PS", b"Patrick Star", b"SpongeBob, I just want to tell you one thing, Patrick needs to be hurt too .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_b2b9bec66b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PS>>(v1);
    }

    // decompiled from Move bytecode v6
}

