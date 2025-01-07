module 0x297b7f887a47fdcdf82364b5b175c2f00c2ece012c06ec7dc58ee7bc0c63aa07::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 9, b"OTTER", b"OTTER", b"Otter. The first Coin in MRC50 protocal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i52dwsbjw2rvuagb4yknsxruq2vwqprdhga6p53ik3co6kzdiwea.arweave.net/R3Q7SCm2o1oAweYU2V40hqtoPiM5gef3aFbE7ysjRYg")), arg1);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::InitTreasuryArgs<OTTER>>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::new_init_treasury_args<OTTER>(0x1::ascii::string(b"OTTER"), v0, v1, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun init_treasury(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::InitTreasuryArgs<OTTER>) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_record(arg0, b"OTTER");
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::init_treasury<OTTER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

