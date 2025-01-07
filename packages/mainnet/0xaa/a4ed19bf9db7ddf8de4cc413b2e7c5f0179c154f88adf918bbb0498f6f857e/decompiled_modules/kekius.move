module 0xaaa4ed19bf9db7ddf8de4cc413b2e7c5f0179c154f88adf918bbb0498f6f857e::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 9, b"KEKIUS", b"KEKIUS", b"From innovator to meme lord, Elon Musk has now embraced his inner 'Kakius Maximus' on Sui. Brace yourselves for the next level of internet culture!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1874012164832583680/86bfAb0N_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKIUS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

