module 0x941503fd865762d3b84d4e540332693ac99c29aa3d1deb3f846465bcfb2d0790::googly {
    struct GOOGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLY>(arg0, 6, b"GOOGLY", b"Googly Cat", b"Googly Cat is the hottest crypto on the Sui in future, bringing the true meaning of phenomenon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/googlycat_69b438c185.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

