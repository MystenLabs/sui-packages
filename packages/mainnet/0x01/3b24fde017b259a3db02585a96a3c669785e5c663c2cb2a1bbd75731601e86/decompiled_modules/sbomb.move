module 0x13b24fde017b259a3db02585a96a3c669785e5c663c2cb2a1bbd75731601e86::sbomb {
    struct SBOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOMB>(arg0, 9, b"Sui Bomb", b"SBOMB", b"MAKE MEME GREATE AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1842571553386770432/WBVoqMeh_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOMB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBOMB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOMB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

