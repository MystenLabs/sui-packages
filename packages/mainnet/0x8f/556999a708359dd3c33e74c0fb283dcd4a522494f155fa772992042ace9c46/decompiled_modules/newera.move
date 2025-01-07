module 0x8f556999a708359dd3c33e74c0fb283dcd4a522494f155fa772992042ace9c46::newera {
    struct NEWERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWERA>(arg0, 6, b"NEWERA", b"The New Era", b"New Era represents an interconnected network of balance and mutuality between Humanity and Artificial Intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731604581005.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWERA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

