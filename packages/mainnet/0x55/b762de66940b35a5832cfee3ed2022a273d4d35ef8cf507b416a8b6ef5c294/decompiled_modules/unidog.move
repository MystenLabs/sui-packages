module 0x55b762de66940b35a5832cfee3ed2022a273d4d35ef8cf507b416a8b6ef5c294::unidog {
    struct UNIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIDOG>(arg0, 6, b"UniDog", b"UNI - Sui CEO's dog", b"Uni is the dog from Evan the Sui CEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_9d644337c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

