module 0xcd021f2eb38642e5789cf61c09a77dc21f878ef1f7189f7905182a16e9fb925c::catgpt {
    struct CATGPT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATGPT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATGPT>>(0x2::coin::mint<CATGPT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: CATGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGPT>(arg0, 9, b"CatGPT", b"CATGPT", b"FULLI GIGA MEGA SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1783483369864765440/xGgxIJDi_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATGPT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGPT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

