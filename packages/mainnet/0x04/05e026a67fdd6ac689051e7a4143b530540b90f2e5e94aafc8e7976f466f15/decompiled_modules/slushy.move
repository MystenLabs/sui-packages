module 0x405e026a67fdd6ac689051e7a4143b530540b90f2e5e94aafc8e7976f466f15::slushy {
    struct SLUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSHY>(arg0, 6, b"SLUSHY", b"Slushy's", b"Slushy's is a meme coin on the Sui Network, making waves in the crypto world! Join our fun, community-driven adventure as we splash our way to the top. Let's create some ripples and enjoy the ride together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihl3nkdsinqtxdeohd7uugl44qmlt45ocmmyxsuuxknousmsb7que")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLUSHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

