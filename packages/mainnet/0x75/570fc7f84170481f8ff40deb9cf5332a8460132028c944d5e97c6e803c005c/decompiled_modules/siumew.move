module 0x75570fc7f84170481f8ff40deb9cf5332a8460132028c944d5e97c6e803c005c::siumew {
    struct SIUMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUMEW>(arg0, 9, b"SIUMEW", b"Siu Mew", b"Mew is Meme on solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmZdVZMmyCfaCXgEWcJ3jsWRzxFWdN38qYUSHxHuoxzJi2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIUMEW>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUMEW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

