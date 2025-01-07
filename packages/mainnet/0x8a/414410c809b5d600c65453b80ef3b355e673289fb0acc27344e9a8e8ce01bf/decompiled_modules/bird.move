module 0x8a414410c809b5d600c65453b80ef3b355e673289fb0acc27344e9a8e8ce01bf::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"BIRD", b"bird", x"24426972642020697320612063727970746f63757272656e637920616e640a0a6f70657261746573206f6e207468652053554920706c6174666f726d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000369_d4990f3f0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

