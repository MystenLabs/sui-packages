module 0x6fd92ff60c5bf2ace99cfc1e08bb58cf0c3413368830e39f9ba11da73437c8a3::turbass {
    struct TURBASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBASS>(arg0, 6, b"TURBASS", b"Turbass", b"A Seabass with a turbo gives you Turbass, the Turbos meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730819523858.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

