module 0x7e614d8fd1455d71063bd7e7567608b2c62dc109682e61a365347bbed8f56168::cyberunit {
    struct CYBERUNIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERUNIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERUNIT>(arg0, 9, b"cyberunit", b"Cyber Unit", b"CYBERUNIT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/896/094/large/-untitled-015.jpg?1728840736")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYBERUNIT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERUNIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERUNIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

