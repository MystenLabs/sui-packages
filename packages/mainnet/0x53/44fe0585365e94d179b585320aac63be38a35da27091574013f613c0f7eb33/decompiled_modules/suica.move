module 0x5344fe0585365e94d179b585320aac63be38a35da27091574013f613c0f7eb33::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica Penguin", b"Suica Penguin is the official mascot of the Japanese Transport system, used by 90+ million people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_05_211755_e03c5a8bdd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

