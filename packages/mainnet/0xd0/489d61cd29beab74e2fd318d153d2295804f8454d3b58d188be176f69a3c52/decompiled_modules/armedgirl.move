module 0xd0489d61cd29beab74e2fd318d153d2295804f8454d3b58d188be176f69a3c52::armedgirl {
    struct ARMEDGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMEDGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMEDGIRL>(arg0, 9, b"armedgirl", b"Armed Girl", b"ARMEDGIRL IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/889/407/large/rui-guo-te-gong-11112222.jpg?1728824174")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARMEDGIRL>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMEDGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARMEDGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

