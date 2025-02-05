module 0x77a68506ff5c3a96e25ff67a38c75da6f0245cfe08febd67fe2bfd7d4af575b0::orbit {
    struct ORBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBIT>(arg0, 6, b"ORBIT", b"OrbitAI", b"Orbital empowers users to deploy autonomous Al Agents with unmatched privacy and control.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738721920706.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORBIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

