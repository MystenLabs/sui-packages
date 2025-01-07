module 0x86b226052b37dbebfc52a4d569cd97b83549b2b0d51636ee2b97013402cb3072::bobara {
    struct BOBARA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOBARA>, arg1: 0x2::coin::Coin<BOBARA>) {
        0x2::coin::burn<BOBARA>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<BOBARA>, arg1: &mut 0x2::coin::Coin<BOBARA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BOBARA>(arg0, 0x2::coin::split<BOBARA>(arg1, arg2, arg3));
    }

    fun init(arg0: BOBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBARA>(arg0, 6, b"BOBARA", b"BOBARA", b"BOBARA Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1653376118424993793/tIaSr7cN_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBARA>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBARA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBARA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

