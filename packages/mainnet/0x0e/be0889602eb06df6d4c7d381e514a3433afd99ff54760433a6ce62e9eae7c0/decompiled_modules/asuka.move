module 0xebe0889602eb06df6d4c7d381e514a3433afd99ff54760433a6ce62e9eae7c0::asuka {
    struct ASUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUKA>(arg0, 9, b"ASUKA", b"Asuka EVA", b"ASUKA IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/076/590/437/large/fhnt-01-1.jpg?1717343730")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUKA>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

