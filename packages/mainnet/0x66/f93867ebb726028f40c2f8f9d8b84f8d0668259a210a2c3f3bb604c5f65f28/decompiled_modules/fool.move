module 0x66f93867ebb726028f40c2f8f9d8b84f8d0668259a210a2c3f3bb604c5f65f28::fool {
    struct FOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOL>(arg0, 6, b"Fool", b"Break Yo Self Fool", x"427265616b20596f2053656c6620466f6f6c20546f6b656e2026204e46542050726f6a65637420666f72200a0a68747470733a2f2f7472616465706f72742e78797a2f7375692f636f6c6c656374696f6e2f3078373133626461313864613663323865326335313230343961343266396562633630376462613132393434653535613534613365366138306663653066316663353f7461623d6d696e74266d696e74546f6b656e49643d36323963663164302d636334372d343662342d613666362d6538313462613438303762630a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Breakyoself_d7094e168b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

