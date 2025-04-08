module 0x94604363da51eb97e99d177858dcda8de60fa6c57b0d3864d416a79d9873a4d::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PLAN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PLAN>(arg0, b"PLAN", b"palaneta", b"Rasta Palaneta PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b3e4ffaefffc622f9dda6f7e6fd60f9fe80fb2797ddb2f17276a68ccb3dc87ef1a49b48a9cad398511968b9e6a967be07e2d78ea6920502c4e375eabdcd74c04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111234"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

