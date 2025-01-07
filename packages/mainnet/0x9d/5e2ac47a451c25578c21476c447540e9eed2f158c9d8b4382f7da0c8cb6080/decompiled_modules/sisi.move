module 0x9d5e2ac47a451c25578c21476c447540e9eed2f158c9d8b4382f7da0c8cb6080::sisi {
    struct SISI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISI>(arg0, 6, b"Sisi", b"sisi", b"SISI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a7198f03_289d_47b8_a1a2_f5b6687de138_b7eaf88132.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISI>>(v1);
    }

    // decompiled from Move bytecode v6
}

