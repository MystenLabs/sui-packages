module 0xe6c89aff55a6ba7714d5ce091406666ef8d4c18fbf1746f66a76c8d8c5737d49::pitcoin {
    struct PITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITCOIN>(arg0, 9, b"PITCOIN", b"pitcoin", b"The Moggiest coin on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CL2bvqdTtYQqhwQC1Ad5GZ7cedW9RrbtUK4AZs9Bpump.png?size=xl&key=fd72c5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PITCOIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITCOIN>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

