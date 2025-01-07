module 0xa685f321b5b09935f9804202ad067b78cfc75be9024200eb6036577719d15806::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"BOBO On Sui", b"BOBO the bear is the popular meme character that is used to satirize poor investment choices and express pessimism in both crypto and traditional finance markets on Twitter(X), Reddit, and the /biz board on 4chan, among other places on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_20_14_07_e43b63ea8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

