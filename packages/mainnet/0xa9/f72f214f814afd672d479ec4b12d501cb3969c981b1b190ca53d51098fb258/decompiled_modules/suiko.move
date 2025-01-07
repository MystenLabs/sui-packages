module 0xa9f72f214f814afd672d479ec4b12d501cb3969c981b1b190ca53d51098fb258::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"SUIKODEN", b"Suikoden is a series of role-playing video games created by Yoshitaka Murayama. The games draw inspiration from the classic Chinese novel Water Margi. Play as the hero who gathers an army of misfits and badasses to take down the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_15_37_36_enhanced_1_a33cc88636.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

