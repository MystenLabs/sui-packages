module 0x1be31de4bea6c1191d7fa5a15737ce2700829bc3cd27877445f7071cb59bad0a::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 9, b"SNOOPY", b"SNOOPY DOG", b"SNOOPY might have some new competition after a real-life lookalike has taken over social media for her striking resemblance to the famous cartoon dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Jc3T67t.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SNOOPY>(&mut v2, 110000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

