module 0x68bd80d6af36c1091ece3ad3e40f33ae2ee5dd123ca13ccd54b8fcd403e738cb::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"Degen", b"Degenui", b"Buy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?q=degen&imgurl=https%3A%2F%2Fassets.coingecko.com%2Fcoins%2Fimages%2F34515%2Flarge%2Fandroid-chrome-512x512.png%3F1706198225&imgrefurl=https%3A%2F%2Fwww.coingecko.com%2Fen%2Fcoins%2Fdegen-base&docid=uQoxLmUGHfzx3M&tbnid=faAIOwmHlzjqJM&vet=12ahUKEwiB-Inxs9qIAxVhopUCHf8ONFwQM3oECH0QAA..i&w=250&h=250&hcb=2&ved=2ahUKEwiB-Inxs9qIAxVhopUCHf8ONFwQM3oECH0QAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGEN>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

