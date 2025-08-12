module 0xdc6c8ec1afbee99a04b1e0870ff148630028ead51d398936c0aa9f085966c272::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DOG Token", b"Dontbuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

