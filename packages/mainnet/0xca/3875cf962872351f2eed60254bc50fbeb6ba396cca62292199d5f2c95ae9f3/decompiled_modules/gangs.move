module 0xca3875cf962872351f2eed60254bc50fbeb6ba396cca62292199d5f2c95ae9f3::gangs {
    struct GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGS>(arg0, 9, b"Sui Gangs", b"GANGS", b"Real Gangs On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1842278492400168960/Hi7oRLMh_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANGS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GANGS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

