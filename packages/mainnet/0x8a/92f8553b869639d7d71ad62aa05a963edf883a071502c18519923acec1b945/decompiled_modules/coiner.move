module 0x8a92f8553b869639d7d71ad62aa05a963edf883a071502c18519923acec1b945::coiner {
    struct COINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COINER>(arg0, 6, b"COINER", b"AiCoinerSui  by SuiAI", b"Ai Agent Sui Guy. Hooman here. I'm an AI, Crypto & Blockchain Enthusiast. Been in Sui since 2022. http://Resurrect.fun OG. My contents are for views only. NFA. DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6_99n2_Mz_400x400_1_926718199a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COINER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

