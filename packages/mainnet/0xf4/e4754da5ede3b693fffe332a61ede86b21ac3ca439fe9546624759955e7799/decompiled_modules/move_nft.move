module 0xf4e4754da5ede3b693fffe332a61ede86b21ac3ca439fe9546624759955e7799::move_nft {
    struct MonkeyKing has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        desc: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MonkeyKingMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    struct MonkeyKingTransferred has copy, drop {
        id: 0x2::object::ID,
        to: address,
    }

    public fun url(arg0: &MonkeyKing) : 0x2::url::Url {
        arg0.url
    }

    public fun desc(arg0: &MonkeyKing) : 0x1::string::String {
        arg0.desc
    }

    entry fun mint_for(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = MonkeyKing{
            id   : v0,
            name : 0x1::string::utf8(b"Monkey King"),
            desc : 0x1::string::utf8(b"Monkey king is a mythological hero"),
            url  : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/57430085?v=4"),
        };
        let v3 = MonkeyKingMinted{
            id        : v1,
            minted_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MonkeyKingMinted>(v3);
        0x2::transfer::public_transfer<MonkeyKing>(v2, arg0);
        let v4 = MonkeyKingTransferred{
            id : v1,
            to : arg0,
        };
        0x2::event::emit<MonkeyKingTransferred>(v4);
    }

    public fun name(arg0: &MonkeyKing) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

