module 0xcdd09c5d183bc01230d6fa1521cfd0a7bb47edd2286d6fee2938d261ce6f1ac::cety {
    struct CETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETY>(arg0, 6, b"CETY", b"Cety sui", b"cety is a cat in a hat and she likes dancing, she wants to date with sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042496_e95d346df8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

