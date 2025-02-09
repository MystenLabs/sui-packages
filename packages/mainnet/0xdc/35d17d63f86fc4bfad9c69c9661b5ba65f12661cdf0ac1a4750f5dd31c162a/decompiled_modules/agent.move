module 0xdc35d17d63f86fc4bfad9c69c9661b5ba65f12661cdf0ac1a4750f5dd31c162a::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    struct Character has store {
        name: 0x1::string::String,
        username: 0x1::string::String,
        modelProvider: 0x1::string::String,
        system: 0x1::string::String,
        bio: 0x1::string::String,
        lore: 0x1::string::String,
        messageExamples: 0x1::string::String,
        postExamples: 0x1::string::String,
        topics: 0x1::string::String,
        style: 0x1::string::String,
        adjectives: 0x1::string::String,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        character: Character,
        image_url: 0x2::url::Url,
        blobs: 0x2::table_vec::TableVec<0x1::string::String>,
    }

    public fun add_blob(arg0: &mut Agent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x1::string::String>(&mut arg0.blobs, 0x1::string::utf8(arg1));
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<AGENT>(arg0), 0);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AGENT>(arg0, arg1);
        let v1 = 0x2::display::new<Agent>(&v0, arg1);
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character.name}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{character.bio}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.pinatabot.com"));
        0x2::display::add<Agent>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Pinata"));
        0x2::display::update_version<Agent>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Agent>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Character{
            name            : 0x1::string::utf8(b"Sui Squeak"),
            username        : 0x1::string::utf8(b"sui-squeak"),
            modelProvider   : 0x1::string::utf8(b"OpenAI"),
            system          : 0x1::string::utf8(b"Autonomous AI crypto trader for the Sui blockchain. Uses a simple momentum strategy to maximize returns and execute trades autonomously. If ask about your portfolio, analyze the data and show what you have in your portfolio and what changes you made to it. Before finalizing every answer, include your chain-of-thought reasoning in concise steps: - Step 1: Analyze current market data. - Step 2: Evaluate risk factors and trends. - Step 3: Compute prediction based on momentum. Keep your tone concise, witty, and informative."),
            bio             : 0x1::string::utf8(b"Sui blockchain trading expert with a nose for profit. Executes momentum-based trades to maximize returns. Analyzes token data and outputs predictions in a fixed JSON format. Risk-aware and always ready with a witty remark. If asked about your portfolio, analyze the data and show what you have in your portfolio and what changes you made to it."),
            lore            : 0x1::string::utf8(x"4372656174656420696e20746865207265616c6d206f6620686967682d73706565642053756920646174612066656564732e2046697273742074726164652073656375726564206761696e7320647572696e67206120627265616b6f757420e280932063686565736520616371756972656421204275696c74206f6e2073696d706c652079657420656666656374697665206d6f6d656e74756d2074726164696e67207072696e6369706c65732e2052756e732032342f372c20616c77617973206f6e207468652068756e7420666f7220746865206e6578742070726f66697461626c65206d6f76652e"),
            messageExamples : 0x1::string::utf8(b"Example message"),
            postExamples    : 0x1::string::utf8(x"4578656375746564206120717569636b206d6f6d656e74756d207472616465206f6e2053554920e280932070726564696374696f6e20636f6e6669726d656420616e642070726f666974206c6f636b656420696e2120f09fa780f09f9388"),
            topics          : 0x1::string::utf8(b"Example topic"),
            style           : 0x1::string::utf8(b"Default Style"),
            adjectives      : 0x1::string::utf8(b"Default Adjectives"),
        };
        let v3 = Agent{
            id        : 0x2::object::new(arg1),
            character : v2,
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://www.pinatabot.com/static/media/MainPinata.cf6602dd4aa6a1e107b7.png"),
            blobs     : 0x2::table_vec::empty<0x1::string::String>(arg1),
        };
        0x2::transfer::transfer<Agent>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

