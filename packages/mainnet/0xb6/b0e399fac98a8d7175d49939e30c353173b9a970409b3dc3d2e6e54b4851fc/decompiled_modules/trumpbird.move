module 0xb6b0e399fac98a8d7175d49939e30c353173b9a970409b3dc3d2e6e54b4851fc::trumpbird {
    struct TRUMPBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBIRD>(arg0, 9, b"TRUMPBIRD", b"Birdcoin", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a8233771078322ad7648e0908a951facblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

