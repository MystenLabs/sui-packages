module 0xa1d6c8749a8178ca76229cab788db11b436d4b234fd35465a1e596d2fb43cbc::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"Deny, Defend, Depose", b"The creator of this meme coin does not support, promote, or encourage any form of violence, harmful behavior, or illegal activity. This project is intended solely as a satirical and cultural phenomenon reflective of our time. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733489355716.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

