module 0x30e3bbf08dd2febdb2a2aa5ba95fd2d9eb984ac0176a42f7270936117253267d::turboman {
    struct TURBOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOMAN>(arg0, 6, b"TurboMan", b"Turbo Man", b"You can always count on me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968646445.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

