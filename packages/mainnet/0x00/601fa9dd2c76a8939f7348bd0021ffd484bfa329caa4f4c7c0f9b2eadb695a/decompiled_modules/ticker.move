module 0x601fa9dd2c76a8939f7348bd0021ffd484bfa329caa4f4c7c0f9b2eadb695a::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 6, b"TICKER", b"What's the Ticker ?", b"please can someone tell me the god dam ticker !!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7840cfc5_0f1c_41ef_b69b_1e89a602a702_e523a65854.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

