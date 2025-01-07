module 0xc6223871bee87389823e54c34f9282e115f83909a31f01b94d9d475bb19431fd::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 6, b"DOGGY", b"SUI DOG", x"4d65657420446f6767792c2053554920646f672077686f206c6f76657320446f6767797374796c652e2048697320707572706f736520697320746f204d616b652053756920477265617420416761696e2e202020200a0a24444f474759", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGGY_b2886a621b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

