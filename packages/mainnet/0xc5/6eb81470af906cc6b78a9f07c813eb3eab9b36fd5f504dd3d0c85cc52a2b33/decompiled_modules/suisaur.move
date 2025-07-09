module 0xc56eb81470af906cc6b78a9f07c813eb3eab9b36fd5f504dd3d0c85cc52a2b33::suisaur {
    struct SUISAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAUR>(arg0, 9, b"SUISR", b"Suisaur", b"A chunky, leaf-backed beast snoozing on a mountain of Sui tokens, with vines that spell SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAUR>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

