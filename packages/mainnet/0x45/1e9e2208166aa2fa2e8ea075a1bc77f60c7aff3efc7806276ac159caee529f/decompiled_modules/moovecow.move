module 0x451e9e2208166aa2fa2e8ea075a1bc77f60c7aff3efc7806276ac159caee529f::moovecow {
    struct MOOVECOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOVECOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOVECOW>(arg0, 6, b"MOOVECOW", b"MOOVEC0W", b"The unofficial cow of Movepump dreaming to bring hope and encouragement to the industry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_17_07_32_48cec06ac2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOVECOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOVECOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

