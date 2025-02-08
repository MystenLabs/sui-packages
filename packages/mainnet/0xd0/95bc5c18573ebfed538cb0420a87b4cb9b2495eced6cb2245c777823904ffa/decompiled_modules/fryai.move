module 0xd095bc5c18573ebfed538cb0420a87b4cb9b2495eced6cb2245c777823904ffa::fryai {
    struct FRYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FRYAI>(arg0, 6, b"FRYAI", b"FRENCHYFRY AI by SuiAI", b"This AI agent would be involved in optimizing potato production and processing, specifically for making French fries. It could analyze data from potato farming to improve harvesting, yield, and processing efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/frnchy_0ae4357519.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

