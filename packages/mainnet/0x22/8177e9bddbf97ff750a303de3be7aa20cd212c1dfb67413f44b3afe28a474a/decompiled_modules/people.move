module 0x228177e9bddbf97ff750a303de3be7aa20cd212c1dfb67413f44b3afe28a474a::people {
    struct PEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEOPLE>(arg0, 6, b"PEOPLE", b"PEOPLE AI by SuiAI", b"We envision a decentralized digital realm where AI is harnessed by the community for the community. PeopleAI seeks to empower users, enabling them to contribute to and benefit from a collective intelligence that enhances their digital experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001182610_22144c94bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEOPLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

