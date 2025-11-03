module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusdp {
    struct RCUSDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCUSDP, arg1: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::treasuryrc::internal_prepare<RCUSDP>(arg0, 6, b"rcUSDp", b"rcUSDp", b"Holders of rcUSD can stake rcUSD and receive rcUSD+ as a receipt evidencing their staked rcUSD and potentially earn staking rewards (yield).", b"https://aquamarine-patient-spoonbill-652.mypinata.cloud/ipfs/bafkreihgfa7wcshhz66bmzcij2w6vjhkx7ho47vu3em6atm534th3taihq", true, arg1);
    }

    // decompiled from Move bytecode v6
}

