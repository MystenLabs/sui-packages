module 0x607528fc4bad5a57a75b0b8383b3c7b085598eac9cc8396b335e541a5c2e73ca::welras_token {
    struct WELRAS_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WELRAS_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WELRAS_TOKEN>>(0x2::coin::mint<WELRAS_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<WELRAS_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48 || 0x2::tx_context::sender(arg2) == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<WELRAS_TOKEN>>(arg0, arg1);
    }

    fun init(arg0: WELRAS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELRAS_TOKEN>(arg0, 9, b"WEL", b"WELRAS", b"Walrus? Nah, that's way too boring. WELRAS brings the party to SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-wrong-vicuna-814.mypinata.cloud/ipfs/bafkreiaa7dqlzbyvsj7tjq7glbgsga7kqt2t4afqa2qj65lpoledwrni44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELRAS_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WELRAS_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

