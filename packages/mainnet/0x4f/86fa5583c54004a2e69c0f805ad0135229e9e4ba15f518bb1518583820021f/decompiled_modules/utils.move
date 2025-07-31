module 0xcc2650b0d0b949e9cf4da71c22377fcbb78d71ce9cf0fed3e724ed3e2dc57813::utils {
    public fun get_description_nft() : vector<u8> {
        b"Bored Ape Sui Club is a whole new existence of 5000 unique Bored Apes with new traits compositions living in the Sui Ecosystem. Not affiliated with Yuga Labs."
    }

    public fun get_hard_cap_holder() : u64 {
        0
    }

    public fun get_hard_cap_private() : u64 {
        1500
    }

    public fun get_hard_cap_public() : u64 {
        5000
    }

    public fun get_hard_cap_total() : u64 {
        5000
    }

    public fun get_hard_cap_whitelist() : u64 {
        3500
    }

    public fun get_image_url() : vector<u8> {
        b"https://ipfs.io/ipfs/bafybeicnuu37rwdmxcn3oobmbvgtji6kn52xtrkysgjn4nrxcnhchfsu4q/assets/"
    }

    public fun get_key_holder() : vector<u8> {
        x"a136fd7c0ca0a75f498c96b4d5f398abd81c28fef63c51cd3e6e96a2b7920705"
    }

    public fun get_key_private() : vector<u8> {
        x"3f61057118f904129f7d58b9da7656dd5854ea1ec935ab85137e8dd6798810b7"
    }

    public fun get_key_public() : vector<u8> {
        x"8c6d6ec73c2457a9a0d2e319625d653d96028922ee4e5550b2a4d8419a460b29"
    }

    public fun get_key_whitelist() : vector<u8> {
        x"41df108bf0be4a6013bdf1c786dd1d4d73fc91916693439ae1bcb34e2ec8a2ae"
    }

    public fun get_metadata_url() : vector<u8> {
        b"https://ipfs.io/ipfs/bafybeicnuu37rwdmxcn3oobmbvgtji6kn52xtrkysgjn4nrxcnhchfsu4q/metadata/"
    }

    public fun get_name_nft() : vector<u8> {
        b"Bored Ape Sui Club #"
    }

    public fun get_number_image() : u64 {
        5000
    }

    public fun get_price_mint_holder() : u64 {
        0
    }

    public fun get_price_mint_private() : u64 {
        2900000000
    }

    public fun get_price_mint_public() : u64 {
        4500000000
    }

    public fun get_price_mint_whitelist() : u64 {
        2900000000
    }

    public fun get_project() : vector<u8> {
        b"boredapesuiclub"
    }

    public fun get_time_end_holder() : u64 {
        0
    }

    public fun get_time_end_private() : u64 {
        1683579600000
    }

    public fun get_time_end_public() : u64 {
        1683590400000
    }

    public fun get_time_end_whitelist() : u64 {
        1683579600000
    }

    public fun get_time_start_holder() : u64 {
        0
    }

    public fun get_time_start_private() : u64 {
        1683561600000
    }

    public fun get_time_start_public() : u64 {
        1683576000000
    }

    public fun get_time_start_whitelist() : u64 {
        1683561600000
    }

    public fun get_type_image() : vector<u8> {
        b".png"
    }

    public fun get_type_metadata() : vector<u8> {
        b".json"
    }

    public fun get_user_mint_max_holder() : u64 {
        0
    }

    public fun get_user_mint_max_private() : u64 {
        10
    }

    public fun get_user_mint_max_public() : u64 {
        5000
    }

    public fun get_user_mint_max_whitelist() : u64 {
        3
    }

    public fun get_version() : u64 {
        1
    }

    public fun get_website() : vector<u8> {
        b"https://twitter.com/BoredApeSuiClub"
    }

    // decompiled from Move bytecode v6
}

