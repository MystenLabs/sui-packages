module 0xb3a8c7c5731900b224cc9c627e59a0462f62de9b8e9431c329d3dc7f8f722306::dogbird {
    struct DOGBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBIRD>(arg0, 6, b"DOGBIRD", b"DogBirdOnSui", b"$DOGBIRD IS A MEME COIN ON SUI BLOCKCHAIN WITH NEW FEATURE AND UTILITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_093509_1892033f0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

