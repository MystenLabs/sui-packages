module 0x1e027c64ed712436772bbff86822af5d17576c02853fcea17645a9374e00e224::shk {
    struct SHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHK>(arg0, 6, b"SHK", b"Sharkly", b"$SHAAARRRRKKKKK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifegjwx6onhj7skgdi626nbfgcddmkjbgkvfqn44pf22rgm5aw7zu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

