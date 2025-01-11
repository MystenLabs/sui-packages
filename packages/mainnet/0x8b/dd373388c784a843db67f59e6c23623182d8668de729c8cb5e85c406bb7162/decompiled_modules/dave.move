module 0x8bdd373388c784a843db67f59e6c23623182d8668de729c8cb5e85c406bb7162::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 6, b"DAVE", b"Dirty Dave AI", b"Hey im Dave, and i like to have a chat and get drunk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a914608_cb87_4a53_be68_484091717086_0964a498ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

