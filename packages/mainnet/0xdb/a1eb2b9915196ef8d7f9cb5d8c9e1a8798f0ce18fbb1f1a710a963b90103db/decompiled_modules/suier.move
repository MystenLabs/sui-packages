module 0xdba1eb2b9915196ef8d7f9cb5d8c9e1a8798f0ce18fbb1f1a710a963b90103db::suier {
    struct SUIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIER>(arg0, 6, b"SUIER", b"SUI TIGER", b"$SUIER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_10_19_466bc531aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

