module 0xb6aae27d25483af3d0da2dec245d7f32bac21d52d2c60094a3d58c3871950f98::bling {
    struct BLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLING, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLING>(arg0, 14265372166484221818, b"JACK BLING FROST", b"BLING", b"Jack Bling Frost is Chill, Cool and full of Bling. He loves Crypto it keeps him looking Icy. Get a Bag of Jack Bling Frost & let's get Icy with him! We are a Community of Crypto Enthusiasts that appreciate & have love for the crypto space.", b"https://images.hop.ag/ipfs/QmdLBXb3ARBudAXRFJyLs4Wg32QujVLGTN4csaASStuwni", 0x1::string::utf8(b"https://x.com/JackBlingFrost"), 0x1::string::utf8(b"https://jackblingfrost.xyz"), 0x1::string::utf8(b"https://t.me/jackblingfrost"), arg1);
    }

    // decompiled from Move bytecode v6
}

