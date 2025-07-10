module 0x31d65f7da531419945fbe1387a9b77c42ad0c6f43168d4a10fe1f43880a3e82d::dgen {
    struct DGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGEN>(arg0, 9, b"DGEN", b"Dgen", b"Backed by Dolbaeb trade. Not Gen D, but D Gen. Unemployed gamblers who goon and eat junk food all day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cache.tonapi.io/imgproxy/lmzGYuxqqZc-dUJ1jd-IaKrdDBzK7_ruXVuz6NcHYpc/rs:fill:200:200:1/g:no/aHR0cHM6Ly9wYnMudHdpbWcuY29tL21lZGlhL0d2SjV4RGVXNEFBeE5WaD9mb3JtYXQ9cG5nJm5hbWU9c21hbGw.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DGEN>>(0x2::coin::mint<DGEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DGEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

