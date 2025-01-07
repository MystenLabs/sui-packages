module 0xf9a6195d4581dd227b7f6cd452a5a7773d84fef612cb694b0859fbb9f4aaf33b::suiget {
    struct SUIGET has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGET>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIGET>>(0x2::coin::mint<SUIGET>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIGET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGET>(arg0, 9, b"SUIGET", b"SUIGET", b"SUIGET iconic meme with expectations of making the community to get SUI, entirely community driven no airdrops, fair launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838963259426095104/hpdsRXE0_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

