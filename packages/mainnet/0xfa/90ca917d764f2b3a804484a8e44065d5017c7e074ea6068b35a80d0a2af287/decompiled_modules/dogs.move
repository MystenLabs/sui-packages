module 0xfa90ca917d764f2b3a804484a8e44065d5017c7e074ea6068b35a80d0a2af287::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 9, b"DOGS", b"Dog Sui", b"Don't miss this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1846625522668982272/5t4ZOgU__400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

