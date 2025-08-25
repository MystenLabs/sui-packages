module 0x6f7be3f263c1c5f61677b4e688a78636385164907608204130b0d40ff92df5::roost {
    struct ROOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOST>(arg0, 6, b"ROOST", b"Sui Rooster", b"$ROOST - The Biggest Cock On The Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieqhlo2qivqucmpekhrsvu5q7l7jyph6dxxofxbp4plmevpxktnle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROOST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

