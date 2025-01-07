module 0x453898362e6380df5aaa6c2f7776cf4004825f3f0671c237b3deeae85cb5d33::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 8, b"BENDER", b"BENDER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/8b/70/df/8b70df1c7b886620488f878ec1085eb3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENDER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

