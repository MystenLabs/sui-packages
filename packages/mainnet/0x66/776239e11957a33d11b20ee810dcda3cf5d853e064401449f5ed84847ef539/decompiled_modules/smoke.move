module 0x66776239e11957a33d11b20ee810dcda3cf5d853e064401449f5ed84847ef539::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 9, b"SMOKE", b"Smoke", b"SMOKE IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/863/829/large/-d83b47792fc39e8c3161d4ddd906122.jpg?1728729157")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOKE>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

