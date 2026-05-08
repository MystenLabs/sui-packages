module 0x6dcb9d2964b742633ff690057645d94840685c3371f2922d30ea79d81808a2a1::asdasas {
    struct ASDASAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASAS>(arg0, 6, b"ASDASAS", b"asasa", b"ASASAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffctnrlk3cnhzdi7eywfxmsns4ac46w2om4xd5lyfhu632itf5ky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDASAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

