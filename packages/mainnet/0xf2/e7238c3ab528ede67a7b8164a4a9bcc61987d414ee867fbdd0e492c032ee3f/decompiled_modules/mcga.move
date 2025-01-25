module 0xf2e7238c3ab528ede67a7b8164a4a9bcc61987d414ee867fbdd0e492c032ee3f::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 6, b"MCGA", b"Trump", b"MCGA Coin is the official token of the Making Crypto Great Again ecosystem, inspired by the return of the 45th President, Donald Trump, to the White House. Powered by a 4,500-piece NFT collection, the token is backed by proceeds from NFT sales and offers exclusive benefits to holders. Be part of the movement and Make Crypto Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_261f33d29a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

