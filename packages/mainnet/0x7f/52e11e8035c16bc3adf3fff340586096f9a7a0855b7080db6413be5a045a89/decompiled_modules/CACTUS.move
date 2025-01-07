module 0x7f52e11e8035c16bc3adf3fff340586096f9a7a0855b7080db6413be5a045a89::CACTUS {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 8, b"CACTUS", b"Sui Cactus", b"just a cactus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://turquoise-worried-tapir-661.mypinata.cloud/ipfs/QmcnMsuaDCdXwQWqcx48rvX11HQzYcLLgLMdaEP1rAzWtA")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CACTUS>>(0x2::coin::mint<CACTUS>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CACTUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

