module 0x3b4b8c39211f34f773624f7d424d3d2759cae958caabc8d8eb8656be13b5a9bf::privatecoin {
    struct PRIVATECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: 0x2::coin::Coin<PRIVATECOIN>) {
        0x2::coin::burn<PRIVATECOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATECOIN>>(0x2::coin::mint<PRIVATECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIVATECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATECOIN>(arg0, 9, b"USDC ", b"Tatr USD", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmegTguLKv9FgfzPaX6NRYAwGUCY3WHuh8McvPaDEV1NZQ")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIVATECOIN>>(v1);
        let v3 = &mut v2;
        mint(v3, 8505624000000000, @0xb36be7bddfdefead4989f310d06b482673c08b550e237b2c40066cfbeea4bbce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v2, @0xb36be7bddfdefead4989f310d06b482673c08b550e237b2c40066cfbeea4bbce);
    }

    // decompiled from Move bytecode v6
}

