module 0xff2f0b5905d598490f03b476ab6c3385cc20c6dc3220950b27fc75f639ac08b3::limob {
    struct LIMOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMOB>(arg0, 9, b"limob", b"Sui Lion Limob", b"LIMOB IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/697/995/large/l-zz-0370.jpg?1728297608")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIMOB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMOB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

