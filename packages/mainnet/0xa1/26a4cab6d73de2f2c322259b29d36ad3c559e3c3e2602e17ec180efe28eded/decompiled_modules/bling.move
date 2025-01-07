module 0xa126a4cab6d73de2f2c322259b29d36ad3c559e3c3e2602e17ec180efe28eded::bling {
    struct BLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLING>(arg0, 6, b"BLING", b"JACK BLING FROST", b"Jack Bling Frost is Chill, Cool and full of Bling. He loves Crypto it keeps him looking Icy. Get a Bag of Jack Bling Frost & let's get Icy with him! We are a Community of Crypto Enthusiasts that appreciate & have love for the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34575_40435ebc2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLING>>(v1);
    }

    // decompiled from Move bytecode v6
}

