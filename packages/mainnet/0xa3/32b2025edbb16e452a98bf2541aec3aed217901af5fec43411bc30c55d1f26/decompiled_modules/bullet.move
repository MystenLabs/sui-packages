module 0xa332b2025edbb16e452a98bf2541aec3aed217901af5fec43411bc30c55d1f26::bullet {
    struct BULLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLET>(arg0, 6, b"BULLET", b"Bullet", x"4665656c696e672042554c4c455420746f2074686520626f6e650a0a42756c6c65742069732074686174206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054029_66539bcd84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

