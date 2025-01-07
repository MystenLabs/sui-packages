module 0x8a970d9bf011b6cb85dc412ba543a8835532544e34b79ea3941aee4b15db15c1::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 9, b"WONKY", b"WonkyCat", b"The newest meme coin on SUI. Be the naughty Cat in Make Sui Great Again with WONKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848126618184671232/GQHrtdRi_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WONKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

