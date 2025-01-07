module 0xea5b351cbb19940a78974a47c8fbd2916d02280fd383bc45b430b9e59930d86c::suitainu {
    struct SUITAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAINU>(arg0, 6, b"Suitainu", b"Sui Akita Inu", b"Sui Akita Inu $Suitainu is here to take on the world with smiles and cuteness! His name is Suitainu, the first and only Akita Inu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_t32412354ulo_1_302c4f60b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

