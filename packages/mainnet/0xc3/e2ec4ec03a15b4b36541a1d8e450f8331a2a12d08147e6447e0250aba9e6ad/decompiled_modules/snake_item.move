module 0xc3e2ec4ec03a15b4b36541a1d8e450f8331a2a12d08147e6447e0250aba9e6ad::snake_item {
    public fun get_description_nft() : vector<u8> {
        b"The primordial life formed from the collision between Evo Eggs and Magic Stones. Snake Legends will soon dominate the Earth."
    }

    public fun get_hard_cap() : u64 {
        4142
    }

    public fun get_image_url() : vector<u8> {
        b"https://ipfs.io/ipfs/bafybeihaskvc5xe6bf4nk2rb4rjmnoprpkdycqvzqpw6otbmq6o3gtijca/"
    }

    public fun get_key() : vector<u8> {
        x"373c66a832dc920a4d339e81da73ce03dde3af00cbdf82ebbdfe0d3d566e0484"
    }

    public fun get_metadata_url() : vector<u8> {
        b"https://ipfs.io/ipfs/bafybeiascaikoduwb5vd6ohbxd2zidqltyjxgjxiy3vzjmqowfkt4zsxfy/"
    }

    public fun get_name_nft() : vector<u8> {
        b"Hunting Snake Legends #"
    }

    public fun get_price_mint() : u64 {
        100000000
    }

    public fun get_project() : vector<u8> {
        b"snake"
    }

    public fun get_type_egg1() : 0x1::ascii::String {
        0x1::ascii::string(b"7b5e851057ef8750d15fe098c84dca0617da8482a020c2ed3a842d7bce6e0ef::keepsake_nft::KEEPSAKE")
    }

    public fun get_type_egg2() : 0x1::ascii::String {
        0x1::ascii::string(b"e4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::evoeggs_collection::EvoEggs")
    }

    public fun get_type_gem() : 0x1::ascii::String {
        0x1::ascii::string(b"aa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<8e5ea344f4dcaf15b6bde057e4ca49532209b4c6f8b92ec2fb36af3d06aa4ff2::collection::Gamio>")
    }

    public fun get_type_image() : vector<u8> {
        b".png"
    }

    public fun get_type_metadata() : vector<u8> {
        b".json"
    }

    public fun get_website() : vector<u8> {
        b"https://tocen.co"
    }

    // decompiled from Move bytecode v6
}

