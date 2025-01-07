module 0x7ccca724ec95cfb9ccc2c8fb13193acfc208e95084661657a494ec3b87ffc2e6::asym {
    struct ASYM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASYM>, arg1: 0x2::coin::Coin<ASYM>) {
        0x2::coin::burn<ASYM>(arg0, arg1);
    }

    fun init(arg0: ASYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ASYM>(arg0, 9, b"ASYM", b"ASYM", b"Agent network identifying high ROI opportunities, allocating capital to those opportunities, and generating returns and value for the $ASYM ecosystem. Website: https://www.asym.top/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/xSZQzB8/DNMTk67ur-DBx-EEVRx9-Hj-Vz-CVu8en4-Kgg5-Hf-Zy3-E6pump.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ASYM>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASYM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASYM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ASYM>>(v1, @0xdd9336bd6dcee4ee01431e40434103cf08d392cffad9804d58f3ba1b6598ae61);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ASYM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ASYM>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASYM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASYM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

