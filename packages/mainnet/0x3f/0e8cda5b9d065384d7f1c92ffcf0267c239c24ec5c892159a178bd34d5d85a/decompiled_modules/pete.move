module 0x3f0e8cda5b9d065384d7f1c92ffcf0267c239c24ec5c892159a178bd34d5d85a::pete {
    struct PETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETE>(arg0, 6, b"PETE", b"Sui Pete", b"Pete disguise level: 0, Meme level: 100.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fake_9f444c2bee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

