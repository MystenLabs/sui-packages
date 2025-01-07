module 0x5dcde86aa31183de93c4c982690e2fa01cf7ba8e177ac355a0597083dd5e8605::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 9, b"tusk", b"Tusk the Walrus", b"Hello, I am currently 15 years old and I want to become a walrus. I know there's a million people out there just like me, but I promise you I'm different. On December 14th, I'm moving to Antarctica; home of the greatest walri. I've already cut off my arms, and now slide on my stomach everywhere I go as training. I may not be a walrus yet, but I promise you if you give me a chance and the support I need, I will become the greatest walrus ever. Thank you all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GU4Q6z1WgAAaI-P?format=jpg&name=medium")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUSK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

