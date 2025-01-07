module 0x8bee6ff0f7d2a4b84f82b0418bd9ed448090c038c8c2324640bd885b3d37f58d::constant {
    public fun get_nft_image(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"bafybeifmgzwrviwh4rv32rxfvjhhtzjn5hqqqhqfxv6x3eufbctzo7txae"
        } else if (arg0 == 2) {
            b"bafybeihbbvngfbncp2nsrqasdz6zmesglb6k277mlt4fta36nd5uck3zte"
        } else if (arg0 == 3) {
            b"bafybeieutfmwgxw5vtto7vezqw3owrezrtejscffuqwlak4m6vnppafceu"
        } else if (arg0 == 4) {
            b"bafybeid53qv6o3cw3qdh6dl6t63v7jpyu3abtn32jvuhxnqeuyw65ow35y"
        } else if (arg0 == 5) {
            b"bafybeihbxgo23eor5r2ujnghvoo27dqq6snpvhmmhvntnp6ufrdxt673je"
        } else if (arg0 == 6) {
            b"bafybeiaunhptecugpne6eqk7nlehruncxg35634qdaac2jdfboepuahzre"
        } else if (arg0 == 7) {
            b"bafybeiepdgugqjdm5qroempbdzfs6t6bgn25srxnkxpwttujckpapzmf4q"
        } else if (arg0 == 8) {
            b"bafybeibx2dulbhjuzeq7kffnvmsc3lqun7hmhv5upugquybmegqkfaivqm"
        } else {
            b"ERROR"
        }
    }

    // decompiled from Move bytecode v6
}

