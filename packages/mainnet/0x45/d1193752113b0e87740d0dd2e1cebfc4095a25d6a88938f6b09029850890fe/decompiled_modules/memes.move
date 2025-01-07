module 0x45d1193752113b0e87740d0dd2e1cebfc4095a25d6a88938f6b09029850890fe::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 9, b"MEMES", b"Memes Sui", b"MEMES COMMING ON SUI TO RULE THEM ALL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1846076832778743808/Ia90HC00_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMES>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMES>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

