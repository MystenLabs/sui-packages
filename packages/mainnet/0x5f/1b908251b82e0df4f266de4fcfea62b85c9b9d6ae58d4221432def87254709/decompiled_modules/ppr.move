module 0x5f1b908251b82e0df4f266de4fcfea62b85c9b9d6ae58d4221432def87254709::ppr {
    struct PPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPR>(arg0, 9, b"PPR", b"Pupperoni", b"Pupperoni is the ultimate memecoin for dog lovers and crypto enthusiasts alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54a3717b-3a34-46b0-a72b-a6c2f0c4b837.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

