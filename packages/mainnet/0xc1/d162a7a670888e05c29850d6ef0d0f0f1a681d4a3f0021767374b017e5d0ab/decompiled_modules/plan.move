module 0xc1d162a7a670888e05c29850d6ef0d0f0f1a681d4a3f0021767374b017e5d0ab::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PLAN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PLAN>(arg0, b"PLAN", b"palaneta", b"Palaneta Rasta PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f4511f3f7b5b37f6d74fd2e7147d672a109452f801736ab8de5548ea24e8da8a23160bcc1d94224c0f133ea1e1e412cdff7d44d0da9ae1e95c271f98e889b60af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744110740"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

