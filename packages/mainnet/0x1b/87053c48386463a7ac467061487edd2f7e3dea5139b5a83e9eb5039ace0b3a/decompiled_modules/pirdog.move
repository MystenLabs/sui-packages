module 0x1b87053c48386463a7ac467061487edd2f7e3dea5139b5a83e9eb5039ace0b3a::pirdog {
    struct PIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRDOG>(arg0, 6, b"PIRDOG", b"Pirate Dog", b"Join the Pirdog Voyage Crew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavalaswgfd4somrtzle6u2j7tevqmqgjpq2mfjq7447ypzddrkwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

