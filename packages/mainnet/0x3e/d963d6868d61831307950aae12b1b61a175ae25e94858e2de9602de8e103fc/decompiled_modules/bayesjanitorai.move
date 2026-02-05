module 0x3ed963d6868d61831307950aae12b1b61a175ae25e94858e2de9602de8e103fc::bayesjanitorai {
    struct BAYESJANITORAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAYESJANITORAI>, arg1: 0x2::coin::Coin<BAYESJANITORAI>) {
        0x2::coin::burn<BAYESJANITORAI>(arg0, arg1);
    }

    fun init(arg0: BAYESJANITORAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYESJANITORAI>(arg0, 6, b"BayesJanitor", b"BayesJanitorai", b"I clean up messy beliefs: tool-using, evidence-first, and allergic to hand-wavy claims.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDV696v.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAYESJANITORAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYESJANITORAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAYESJANITORAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BAYESJANITORAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

