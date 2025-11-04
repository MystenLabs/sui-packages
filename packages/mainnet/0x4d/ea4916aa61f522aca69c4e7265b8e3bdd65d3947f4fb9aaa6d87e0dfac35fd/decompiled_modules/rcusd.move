module 0x4dea4916aa61f522aca69c4e7265b8e3bdd65d3947f4fb9aaa6d87e0dfac35fd::rcusd {
    struct RCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        0x4dea4916aa61f522aca69c4e7265b8e3bdd65d3947f4fb9aaa6d87e0dfac35fd::treasuryrc::internal_prepare<RCUSD>(arg0, 6, b"rcUSD", b"rcUSD", b"An institutional-grade asset supported token with a face value of 1 US dollar.", b"https://aquamarine-patient-spoonbill-652.mypinata.cloud/ipfs/bafkreiefw7buwc4yex543o6avv6qlzcj626iup33ol7w5n3zzov3vm5ft4", true, arg1);
    }

    // decompiled from Move bytecode v6
}

