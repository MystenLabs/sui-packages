module 0xbd3554f6b8d58236bc7994c215db7046fc4c8ff0c891dbecf2bb28006e9ab378::gate {
    struct GATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATE>(arg0, 9, b"GATE", b"Gatekeeper", b"@GatekeeperTechBot operates similarly to the Safeguard Portal but adds a token verification step for access. When users click the entry button, they are directed to a direct message where the bot requests they send 1 $COIN to a specified verification address. Upon detection of the deposit, the bot instantly provides a unique invite link, allowing the verified user to join the designated group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQUH5eujPJTDAbBEhJSi7QQ8syfVVMfRZFaULoiNdqccc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GATE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

