module 0xe860eb5837bb496a5a8dfc7f6ad2a3401d0297341acd7f05b2fee9bed760c91a::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 6, b"CAPO", b"Capo '' The Mafia on Sui ''", b"I'm gonna make him an offer he can't refuse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N1_Ta_UU_1_400x400_b9d2efe5af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

