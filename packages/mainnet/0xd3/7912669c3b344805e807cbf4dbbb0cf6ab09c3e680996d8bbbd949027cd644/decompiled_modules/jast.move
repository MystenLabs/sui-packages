module 0xd37912669c3b344805e807cbf4dbbb0cf6ab09c3e680996d8bbbd949027cd644::jast {
    struct JAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAST>(arg0, 6, b"JAST", b"JUST A SUI TOKEN", x"574520444f4e54204e454544204d4f5245204d454d4520434f494e532e0a5745204f4e4c59204e454544204f4e45204d454d4520434f494e2e0a4954532043414c4c4544204a55535420412053554920544f4b454e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JUST_A_SUI_c181d2ca95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

