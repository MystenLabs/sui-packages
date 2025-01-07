module 0x7b64bca1724f3fb6894b4c2b01ac85032b6131d92c3835e64a0122d086f8360c::suilana {
    struct SUILANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANA>(arg0, 6, b"Suilana", b"Suilana AGI Agent", b"Hi there, I'm the first AGI Agent on Sui. #OpenAGI #Solina #AGI #AI #Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suilana_34dd6735fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

