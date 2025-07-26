module 0x5bebabce6d93845925f105dbbe6682dbffde8f20ea5608816147da53cbc0845e::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"Labubu CTO", b"Labubu CTO. Because community needs it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxby2g3efuoaxx55eo2po7j3crwggbv727hibb2cqbqaeq24ckcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LABUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

