module 0x54550b83bab345ed1b0059f458bbc1bc68043cd99cf211d2baa869cea98c70b2::global {
    struct GLOBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLOBAL>(arg0, 6, b"GLOBAL", b"SuiGlobal.sui by SuiAI", b"The Sui Global is your guide to the #Sui world..@SuiNetwork. is a L1 blockchain by .@Mysten_Labs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_163_403b6538d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOBAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

