module 0xab6ffc1fa271802e7c867656fe17a2f2572f32fc011e8a9fcc084467bae03122::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"SUI BOBO", b"\"Bobo the Bear\" is a popular meme character that is used to satirize poor investment choices and express pessimism in both crypto and traditional finance markets on Twitter(X), Reddit, and the /biz board on 4chan, among other places on the internet. The $Bobo coin is run by rekt_teka$hi, an OG meme artist, who has been creating Bobo content since the meme first gained popularity in 2018.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb90b2a35c65dbc466b04240097ca756ad2005295_b0c1aa79ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

