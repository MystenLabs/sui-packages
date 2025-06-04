module 0x421e8dc1acc7aceba988fca0bd55474c69116a916d67ee0565ccab96874be3c::oxygen {
    struct OXYGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXYGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXYGEN>(arg0, 6, b"OXYGEN", b"Sui oxygen", b"Ox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihoaogbebwqbbgsjwtlwiuuygoomzvqtb57jnmvl2qvwqwyhk5ybq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXYGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OXYGEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

