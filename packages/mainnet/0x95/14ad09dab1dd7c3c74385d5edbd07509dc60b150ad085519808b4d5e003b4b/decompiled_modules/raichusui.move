module 0x9514ad09dab1dd7c3c74385d5edbd07509dc60b150ad085519808b4d5e003b4b::raichusui {
    struct RAICHUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAICHUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAICHUSUI>(arg0, 9, b"RAISUI", b"Raichusui", b"An orange electric rodent with a lightning tail curving into the Sui emblem, zapping Sui coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidmdesxkiphv2aw735xvdetiaqcn5azngmhoko4fdrfrjjwigweju")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAICHUSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAICHUSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAICHUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

