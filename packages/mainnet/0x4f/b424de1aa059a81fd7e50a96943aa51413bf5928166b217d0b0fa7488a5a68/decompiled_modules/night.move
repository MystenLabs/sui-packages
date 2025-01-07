module 0x4fb424de1aa059a81fd7e50a96943aa51413bf5928166b217d0b0fa7488a5a68::night {
    struct NIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGHT>(arg0, 6, b"Night", b"sui curry", b"CURRY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chief_ca2bfc9d63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

