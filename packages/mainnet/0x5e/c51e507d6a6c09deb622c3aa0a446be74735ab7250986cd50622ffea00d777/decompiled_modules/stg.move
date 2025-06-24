module 0x5ec51e507d6a6c09deb622c3aa0a446be74735ab7250986cd50622ffea00d777::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG>(arg0, 6, b"STG", b"SuisterGo", b"First PVP game on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicp6vto6nqxsvhm7swxdobqhm5wagz342v2o7jd3tvq7yq6mwhg4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

