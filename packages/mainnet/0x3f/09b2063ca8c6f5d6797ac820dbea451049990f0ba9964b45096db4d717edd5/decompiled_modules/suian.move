module 0x3f09b2063ca8c6f5d6797ac820dbea451049990f0ba9964b45096db4d717edd5::suian {
    struct SUIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAN>(arg0, 9, b"SUIAN", b"SUIANA", b"A NEW COIN ON SUI NETWORK, WAIT FOR MORE UPDATES AND FUNDING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2722c6301892f9fc2523b89ca31a0225blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

