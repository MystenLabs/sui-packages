module 0x49ef7cb6ab6e1434d90d341afa8d22767f9043488203360d5a71ca4ce1fcef9d::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 6, b"FREE", b"Free", b"Everything is free ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7001_bee60ebfea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

