module 0x35f60449ff05ec249e8d3b49e71d4ccd96ffa6147e3c356bf91f6803bce36db1::nft {
    struct TWIAGLENFT has store, key {
        id: 0x2::object::UID,
        idx: u64,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct TwiagleNftCap has store, key {
        id: 0x2::object::UID,
        cur_supply: u64,
    }

    public entry fun transfer(arg0: TWIAGLENFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TWIAGLENFT>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TwiagleNftCap{
            id         : 0x2::object::new(arg0),
            cur_supply : 0,
        };
        0x2::transfer::public_transfer<TwiagleNftCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_nft(arg0: &mut TwiagleNftCap, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.cur_supply = arg0.cur_supply + 1;
        let v0 = TWIAGLENFT{
            id          : 0x2::object::new(arg1),
            idx         : arg0.cur_supply,
            description : 0x1::string::utf8(b"twiagle nft"),
            url         : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/20042669?s=96&v=4"),
        };
        assert!(arg0.cur_supply <= 237, 0);
        0x2::transfer::public_transfer<TWIAGLENFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

