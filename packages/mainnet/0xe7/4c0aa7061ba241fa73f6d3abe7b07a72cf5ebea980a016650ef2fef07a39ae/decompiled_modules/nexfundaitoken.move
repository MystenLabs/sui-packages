module 0xe74c0aa7061ba241fa73f6d3abe7b07a72cf5ebea980a016650ef2fef07a39ae::nexfundaitoken {
    struct NEXFUNDAITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXFUNDAITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXFUNDAITOKEN>(arg0, 6, b"NexFundAIToken", b"NexFundAI Token", b"The NexFundAI Token was a cryptocurrency token created at the direction of law enforcement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_09_231459_02d2ec488f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXFUNDAITOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXFUNDAITOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

