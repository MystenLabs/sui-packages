module 0xe4d1e64ca9c96fcd020d1a1c609b8aef72311e46e85809c5ebfd6139a80412d2::dm {
    struct DM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DM>(arg0, 14299612642830161172, b"Dolphin Madness", b"DM", x"41206d61646e657373206973206861756e74696e672053554920e280942074686520446f6c7068696e204d61646e6573732e0a5468652066697273742043554c5420636f696e206f6e205355492e", b"https://images.hop.ag/ipfs/QmU9ZVgj62wqCXyPMoV3Yr7ELFQC1EnxxiXdMjYbvUzYE8", 0x1::string::utf8(b"https://x.com/DmOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+poFIml7Z5vhlMTU1"), arg1);
    }

    // decompiled from Move bytecode v6
}

