module 0x9a299eb0608bbe8a8041b0afa5373a00a1d4fb1ca65df71e378fe866367550b4::rakky {
    struct RAKKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKY>(arg0, 6, b"Rakky", b"Rakkyyysui", b"Rakkkkkkky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000158812_8f11daf3f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

