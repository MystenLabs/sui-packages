module 0x8f0ab3213ec5706855d3a73858be6fd8e153ee7d4796b059385d24cf1e6708d2::bblhh {
    struct BBLHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLHH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BBLHH>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BBLHH>(arg0, b"BBLHH", b"GTXHH", b"GTXHH BBLHH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZVZHCikUKJoNUyyPNent6AwLRe91WZ4MBX7Dhg3KvYSX")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fb9cf786a7d4b9971f5828e7b2bc1bef22e8aa2aa26fef64e0377982f0176f3b3e0851e0caf4a65599bd1b1f4765f0af945cd45c8afa543c70f412ae3c8bb802f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745585105"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

