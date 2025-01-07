module 0xa805ad35f07ba58bf00b99482ff2be5efed0fce4d6033ff85510fe795d239a6b::dalmatian {
    struct DALMATIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALMATIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DALMATIAN>(arg0, 9, b"DALMATIAN", b"SQUIDGAME", b"Squid Games Token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYad4HGXjyAfDNWhCVexk6MLHSkrXF3uvNFFpD1cgguqp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DALMATIAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DALMATIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALMATIAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

