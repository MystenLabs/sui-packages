module 0xf7b5ed625e10625aa7f1476a478478f7baa9c48413e387c5d3f287d971b4514c::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 6, b"MOG", b"Mermaid Dog", b"Hey, guys! I'm the only mermaid dog on the  Sui network. If they say there is another one, it is fake news. Water is my natural habitat and fish are my friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhj27ie3bqm7at7pqxkvrk4tzuwa2by4iymxxndcd42a6yuwsrg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

