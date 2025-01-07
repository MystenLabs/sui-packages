module 0xdf7f6d92e3f71ae09bc4f7515701c27956ba8d771b354e48db8fdde739312d68::badeng {
    struct BADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADENG>(arg0, 6, b"BADENG", b"Babydeng On sui", b"Hello, Im baby moodeng on sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018401_5eeb7a1931.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

