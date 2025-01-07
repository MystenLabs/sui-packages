module 0x73c509a0bfb4ce2c0f8e650f946c34e2542fd0a87a69257dcfbed0a228ff02a2::uniai {
    struct UNIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<UNIAI>(arg0, 14403171004054611034, b"Acid Unicorn", b"UNIAI", b"Unicorn took too much acid. Acid Unicorn AI has been trained to spit out non-stop psychedelic nonsense. Drop a tab on our website, as the unicorn a question (she doesn't make much sense cuz she's tripping) and join our quest to find the rainbow hidden on the dark side of the moon!", b"https://images.hop.ag/ipfs/QmQ1paLWkCvMyZrA4CZPRYeLRViL47NfeZcZ9dFLVKWM6z", 0x1::string::utf8(b"https://x.com/Acid_Unicorn_Ai"), 0x1::string::utf8(b"https://acidunicornai.xyz/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

