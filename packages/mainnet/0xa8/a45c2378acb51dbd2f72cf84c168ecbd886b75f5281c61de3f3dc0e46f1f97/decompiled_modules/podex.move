module 0xa8a45c2378acb51dbd2f72cf84c168ecbd886b75f5281c61de3f3dc0e46f1f97::podex {
    struct PODEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODEX>(arg0, 6, b"PODEX", b"POKEDEX ON SUI", b"POKEDEX OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab3irmgksklippz7vh5ryr7dhqmn2u7xvnn5cfxymjmqgbro52qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PODEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

