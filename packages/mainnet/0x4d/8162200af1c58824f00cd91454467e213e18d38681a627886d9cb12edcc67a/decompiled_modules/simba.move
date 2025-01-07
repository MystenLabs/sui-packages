module 0x4d8162200af1c58824f00cd91454467e213e18d38681a627886d9cb12edcc67a::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 9, b"SIMBA", b"SIMBA", b"SIMBA Telecom is the new force in the Singapore telecommunications market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1574700672691621889/PyQa4PZR_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMBA>(&mut v2, 200000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

