module 0x84fcabc2da4b3567ec6dc287cfaee1d273240b809396b3909ed7af909b75fc16::FISHToken {
    struct FISHTOKEN has key {
        id: 0x2::object::UID,
        supply: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        reflections: 0x2::balance::Balance<0x2::sui::SUI>,
        liquidity: 0x2::balance::Balance<0x2::sui::SUI>,
        buybacks: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Metadata has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::string::String,
    }

    fun create_token(arg0: &mut 0x2::tx_context::TxContext) : FISHTOKEN {
        FISHTOKEN{
            id     : 0x2::object::new(arg0),
            supply : 420000000000000,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_token(arg0);
        0x2::transfer::transfer<FISHTOKEN>(v0, @0xdc2658843949e0b41e798cd0fca454706396800526f561809d8dae1beef1d1ee);
        let v1 = Treasury{
            id          : 0x2::object::new(arg0),
            reflections : 0x2::balance::zero<0x2::sui::SUI>(),
            liquidity   : 0x2::balance::zero<0x2::sui::SUI>(),
            buybacks    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<Treasury>(v1, @0xdc2658843949e0b41e798cd0fca454706396800526f561809d8dae1beef1d1ee);
        let v2 = Metadata{
            id       : 0x2::object::new(arg0),
            name     : 0x1::string::utf8(b"MoonFishAI"),
            symbol   : 0x1::string::utf8(b"$FISH"),
            decimals : 18,
            icon_url : 0x1::string::utf8(b"https://sora.chatgpt.com/g/gen_01jvk2s8q4e4rv47w6rrn0d91k"),
        };
        0x2::transfer::transfer<Metadata>(v2, @0xdc2658843949e0b41e798cd0fca454706396800526f561809d8dae1beef1d1ee);
    }

    // decompiled from Move bytecode v6
}

