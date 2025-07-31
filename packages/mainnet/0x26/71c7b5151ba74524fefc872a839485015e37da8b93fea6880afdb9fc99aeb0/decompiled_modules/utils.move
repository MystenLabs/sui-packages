module 0x4d0ef122cefd24247930bc65de4c128dce1952a7f0fe82bed8b5424f0ee44737::utils {
    public fun get_description_nft() : vector<u8> {
        b"Sui Citizen is a 5,000 Exclusive NFT Citizenship providing holders access to WEB3. Sui Citizen has taken an exciting and innovative approach to community-building. We truly believe in the future of Sui and want to invest in its ecosystem as it builds and expands."
    }

    public fun get_hard_cap_holder() : u64 {
        0
    }

    public fun get_hard_cap_private() : u64 {
        280
    }

    public fun get_hard_cap_public() : u64 {
        3520
    }

    public fun get_hard_cap_total() : u64 {
        5000
    }

    public fun get_hard_cap_whitelist() : u64 {
        1200
    }

    public fun get_image_url() : vector<u8> {
        b"https://ipfs.io/ipfs/bafybeicufpsz4vecf76uqlhtajvghpw7okk3fxuqo6uv3hlfai6agtq344/"
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
        b"https://ipfs.io/ipfs/bafybeihffqo7p5yb3zqoxu2ipma2ojgh6xb3l3krw3xvkzmfcyt3brziku/"
    }

    public fun get_name_nft() : vector<u8> {
        b"Sui Citizen #"
    }

    public fun get_number_image() : u64 {
        5000
    }

    public fun get_price_mint_holder() : u64 {
        0
    }

    public fun get_price_mint_private() : u64 {
        0
    }

    public fun get_price_mint_public() : u64 {
        22000000000
    }

    public fun get_price_mint_whitelist() : u64 {
        11000000000
    }

    public fun get_project() : vector<u8> {
        b"suicitizen"
    }

    public fun get_time_end_holder() : u64 {
        0
    }

    public fun get_time_end_private() : u64 {
        1683543600000
    }

    public fun get_time_end_public() : u64 {
        1683565200000
    }

    public fun get_time_end_whitelist() : u64 {
        1683547200000
    }

    public fun get_time_start_holder() : u64 {
        0
    }

    public fun get_time_start_private() : u64 {
        1683540000000
    }

    public fun get_time_start_public() : u64 {
        1683547200000
    }

    public fun get_time_start_whitelist() : u64 {
        1683543600000
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
        1
    }

    public fun get_user_mint_max_public() : u64 {
        10
    }

    public fun get_user_mint_max_whitelist() : u64 {
        3
    }

    public fun get_version() : u64 {
        1
    }

    public fun get_website() : vector<u8> {
        b"https://twitter.com/SuiCitizen"
    }

    // decompiled from Move bytecode v6
}

