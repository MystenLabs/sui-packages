module 0xde1fd3bc0b3d5c6babe9c0585a134314ba41d41b022a8aa75d803fca57321de6::trumpai {
    struct TRUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPAI>(arg0, 6, b"TRUMPAI", b"TrumpAI", b"built for leadership and influence, designed to make bold decisions and drive results. With a focus on strategy, negotiation, and charisma, it thrives in highstakes environments, always aiming for success and commanding attention with its unwavering confidence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20241227_000814_Discord_aa845f943b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

