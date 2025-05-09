module 0xdf1e65ece31ec02828c91e7cf5226963ce4464b8fdde44b1888059b535139d55::crabchill {
    struct CRABCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABCHILL>(arg0, 6, b"CRABCHILL", b"CHillCRAB", b"Chilling under the sea. Chillcrab is here to dominate the season of SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkbb2goo4vntjnx2u5wxejtq7jzgb3g62x6sg3qp6arsokavc2f4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRABCHILL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

