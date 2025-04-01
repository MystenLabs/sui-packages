module 0xd32799216aa932621c469480caf8be02aff95eebf23ebd08a66bc16dd6381eb1::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 9, b"DOG", b"DOG ON SUI", b"First DOG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/892dfb22f8184ab540a0c7aba23ea1efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

