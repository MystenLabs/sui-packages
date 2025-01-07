module 0x1e5b74a5e5aa72cd75ec3e37f7f7bc6bd2e62de89d1f3de94f283b2afc789ded::squirts {
    struct SQUIRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTS>(arg0, 6, b"SQUIRTS", b"$SQUIRT", b"Just a squirt, nothing more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gggw_3f2a4ca459.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

