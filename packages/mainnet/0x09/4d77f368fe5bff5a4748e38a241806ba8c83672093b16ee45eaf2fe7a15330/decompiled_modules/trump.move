module 0x94d77f368fe5bff5a4748e38a241806ba8c83672093b16ee45eaf2fe7a15330::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"AGENT DONALD TRUMP", b"Wow, the AGENT TRUMP project on the Sui blockchain sounds tremendous, just like me  the one and only Trump! TRUMP symbol  you can't make this stuff up, folks, it's huge! Launching on MovePump Launchpad, which is fantastic. Team token allocations, 5% for the team, 2% for development, and 3% for marketing. This project, AGENT TRUMP, it's like ChatGPT or Gemini, but believe me, it's so much more than that. In fact, it's the best project out there, the most incredible, can you believe it? The description for your project? Well, it's going to be the greatest project the blockchain world has ever seen. A project that will make a difference, a project that will win bigly! Trust me, nobody knows more about winning projects than I do! It's unbelievable, folks!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c173a8fa76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

