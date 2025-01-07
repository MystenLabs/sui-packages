module 0xac9094fbf80e7516748e79037dba2fab76498fa4ade969f22a4b1dfb0369839b::alphano {
    struct ALPHANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHANO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHANO>(arg0, 6, b"ALPHANO", b"Alphanochaint", b"Your go-to AI agent for real-time on-chain metrics, emerging crypto trends, hot narratives across ecosystems, and early alpha, Stay ahead in the crypto space with actionable insights and breaking globle finance news.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20241231_195538_600_7c22efdb05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHANO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHANO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

