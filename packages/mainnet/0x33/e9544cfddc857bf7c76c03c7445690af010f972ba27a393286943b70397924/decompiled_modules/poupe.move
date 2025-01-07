module 0x33e9544cfddc857bf7c76c03c7445690af010f972ba27a393286943b70397924::poupe {
    struct POUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POUPE>(arg0, 6, b"POUPE", b"POUPE SUI", b"Your new best friend in the crypto jungle, built on Sui...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poupe_07ead0aac0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

