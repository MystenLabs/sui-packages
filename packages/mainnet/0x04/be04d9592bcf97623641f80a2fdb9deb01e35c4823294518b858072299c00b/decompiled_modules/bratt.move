module 0x4be04d9592bcf97623641f80a2fdb9deb01e35c4823294518b858072299c00b::bratt {
    struct BRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATT>(arg0, 6, b"BRATT", b"Bratt on Sui", b"Revolutionizing the memecoin landscape with innovative utilities and community-driven features.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_6_bd96193bb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

