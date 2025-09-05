module 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd {
    struct RCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::internal_prepare<RCUSD>(arg0, 6, b"rcUSD", b"rcUSD", b"An institutional-grade asset supported token with a face value of 1 US dollar.", b"https://aquamarine-patient-spoonbill-652.mypinata.cloud/ipfs/bafkreiefw7buwc4yex543o6avv6qlzcj626iup33ol7w5n3zzov3vm5ft4", true, arg1);
    }

    // decompiled from Move bytecode v6
}

