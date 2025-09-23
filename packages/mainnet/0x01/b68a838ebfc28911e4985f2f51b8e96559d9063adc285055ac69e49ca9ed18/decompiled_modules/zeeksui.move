module 0x1b68a838ebfc28911e4985f2f51b8e96559d9063adc285055ac69e49ca9ed18::zeeksui {
    struct ZEEKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEEKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEEKSUI>(arg0, 6, b"ZEEKSUI", b"Zeek On Sui", b"The legendary meme cat conquering the Sui ecosystem. From memes to trading platform  expanding into childrens education and tracking platform with tokens!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibot6a4wlp35ifuxxhteo77b7wr6s63pipnhxmpgwmp2chqc6wt2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEEKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEEKSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

