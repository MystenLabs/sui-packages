module 0xd22f9d979035905aeafee49776dd292746432ffd310e57c3bedf5f340118a71::talent {
    struct TalentManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Talent has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        career: 0x1::string::String,
        profile_url: 0x2::url::Url,
        url: 0x2::url::Url,
        level: u32,
        stars: u32,
    }

    public fun url(arg0: &Talent) : &0x2::url::Url {
        &arg0.url
    }

    public fun generate_talent(arg0: &TalentManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Talent{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SWAP_TALENT"),
            career      : 0x1::string::utf8(b"PM"),
            profile_url : 0x2::url::new_unsafe(0x1::ascii::string(b"https://swap.work/profile")),
            url         : 0x2::url::new_unsafe(0x1::ascii::string(b"https://swap-onchain-picture.s3.ap-northeast-1.amazonaws.com/engineering.png")),
            level       : 0,
            stars       : 0,
        };
        0x2::transfer::public_transfer<Talent>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TalentManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TalentManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

