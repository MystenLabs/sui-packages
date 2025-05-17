module 0x51d88e14083478b5de5d17a430fc30d7386c23317f3e5f64b07492d7265af90f::misu {
    struct MISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISU>(arg0, 6, b"Misu", b"MISUI", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkjdy3fddrwappdoonihlmv4tsqeyhzabrimwdaihtrmnli3mi2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

