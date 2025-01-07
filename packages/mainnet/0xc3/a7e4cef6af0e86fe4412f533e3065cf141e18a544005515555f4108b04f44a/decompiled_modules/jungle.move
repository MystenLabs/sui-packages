module 0xc3a7e4cef6af0e86fe4412f533e3065cf141e18a544005515555f4108b04f44a::jungle {
    struct JUNGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNGLE>(arg0, 9, b"JUNGLE", b"Jungle", b"JUNGLE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/491/247/large/jo-yongseok-jungle-04.jpg?1727721201")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUNGLE>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNGLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

