module 0x95d69ccf817f506c306621f837436f6f8b71b06d0f923067026e1a961491f11b::big_beagle {
    struct BIG_BEAGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG_BEAGLE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 608 || 0x2::tx_context::epoch(arg1) == 609, 1);
        let (v0, v1) = 0x2::coin::create_currency<BIG_BEAGLE>(arg0, 7, b"BEAGL", b"Big Beagle", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreicuu36mazrcpipcuvxf4r7yspsehdnxo2njxcwi4ih5bv3edmlcn4.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIG_BEAGLE>(&mut v2, 70000000000000000, @0x758f534a1ce3b3b3911e06474b0a204be6efc2d1b27235de41ff270c5dc5e48f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG_BEAGLE>>(v2, @0x758f534a1ce3b3b3911e06474b0a204be6efc2d1b27235de41ff270c5dc5e48f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIG_BEAGLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<BIG_BEAGLE>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG_BEAGLE>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<BIG_BEAGLE>, arg1: &mut 0x2::coin::CoinMetadata<BIG_BEAGLE>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<BIG_BEAGLE>(arg0, arg1, arg2);
        0x2::coin::update_symbol<BIG_BEAGLE>(arg0, arg1, arg3);
        0x2::coin::update_description<BIG_BEAGLE>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<BIG_BEAGLE>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

