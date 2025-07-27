module 0x5446164f10e4fa93d78f125b0c252f34ac6060698c2f86e465e45946083b3d95::suinions {
    struct SUINIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIONS>(arg0, 6, b"SUINIONS", b"SUI MINIONS", b"IM SUINION ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidhez634ugkuusdnpvhs7x7j3n5c5uhyxguzb34tmw6hyhvysytpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINIONS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

