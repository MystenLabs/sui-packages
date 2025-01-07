module 0x13120a44e9b06fffbe81398d5a3b9b0c7b3ec25eae8d784f7049380dc5216af1::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BONE>(arg0, 16280547702283588167, b"Bone", b"BONE", b"Bone is a memecoin that makes a difference in sui Blockchain with open source, bone will make the sui community hype", b"https://images.hop.ag/ipfs/QmNwpp5pyxqe4YmfT4aoe2Jo8NCkjWjRLhJGbNoR3nhSmS", 0x1::string::utf8(b"https://x.com/Boneonsui"), 0x1::string::utf8(b"https://bonesui.click/"), 0x1::string::utf8(b"https://t.me/bonesui"), arg1);
    }

    // decompiled from Move bytecode v6
}

