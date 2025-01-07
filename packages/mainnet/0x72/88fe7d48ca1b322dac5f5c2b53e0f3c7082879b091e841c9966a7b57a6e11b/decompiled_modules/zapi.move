module 0x7288fe7d48ca1b322dac5f5c2b53e0f3c7082879b091e841c9966a7b57a6e11b::zapi {
    struct ZAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAPI>(arg0, 6, b"ZAPI", b"Zapicorn", b"The First Fully Decentralized #SUI Token Conceptualized by the First Decentralized AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052157_6371ba9dca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

