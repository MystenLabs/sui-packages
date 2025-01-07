module 0x330e2817dfda99537ba5e9c15035b1a190788e99810d9972a82deabd39d29698::lgtv {
    struct LGTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGTV>(arg0, 6, b"LGTV", b"Let Gays Touch Vagina", b"You desired about hot chicks during sui meta? Reality is different and its the Gayiest meta now. Observing it together with $LGTV - LET GAYS TOUCH VAGINA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_dfd5ebf9c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

