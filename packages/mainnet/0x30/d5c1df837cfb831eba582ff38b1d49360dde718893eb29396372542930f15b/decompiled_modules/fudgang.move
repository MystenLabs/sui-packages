module 0x30d5c1df837cfb831eba582ff38b1d49360dde718893eb29396372542930f15b::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"Fuddies Gang", b"AI NFT Collection & Meme coin on $SUI. Let's make Fuddies great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_28_T223417_912_8bd6834010.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

