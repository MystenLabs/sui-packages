module 0xea438f8e146a0adaf8c06c1570df20c4cb247d2e36ff6626ce8ad7a5b050f92c::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"Pump", b"IKA MEME", b"TRUST TO SUI AND IKA TEAM THEN GET HIGH REWARD , ika airdrop hint lets see soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/866f63c6fbb99ab449da9f812243d202blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

