module 0x35244b4ce52ee957819ccfbfddb5ef8abde0af9bf8c040c360841618bda11db6::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 6, b"STC", b"ShitCoin", b"Welcome to the golden age of greatness with SHIT Coin, the meme coin thats truly the GOAT! This isnt just any token; its a tribute to excellence, community, and, well a little bit of poop. Get ready to dive into a journey where greatness meets the power of literal crap on the blockchain. Because why settle for average, when you can be the shit?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727273862716_c22c9bb5b639d11453947bc19ec41a2e_b7395c8973.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

