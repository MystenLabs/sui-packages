module 0x52fa27c37e55dc57a6b0d7183c10c8639d5078cb54cf6b58359d849e05482ecd::stinky {
    struct STINKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STINKY>, arg1: 0x2::coin::Coin<STINKY>) {
        0x2::coin::burn<STINKY>(arg0, arg1);
    }

    fun init(arg0: STINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINKY>(arg0, 9, b"$STINKY", b"STINKY", b"STINKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXXXeV6VXHuzxcTH1FGkZ2QyAxs8xv88b2YBpSRGdLyBN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STINKY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STINKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

