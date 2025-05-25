module 0xd83db71b0ac565d124ba75d824a9ea613a74c00df20e73ca99c7a7262fd06fcc::elekid {
    struct ELEKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEKID>(arg0, 6, b"Elekid", b"Ele Sui", b"Welcome to the next generation of memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0456_28180124ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

