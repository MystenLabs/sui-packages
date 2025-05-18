module 0x55dfcbfc2e3ff4e6fc809f9d2e51d0f3b934ff50f2c1f720412b286859f70fc::nomon {
    struct NOMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMON>(arg0, 6, b"NOMON", b"NOKEMON", b"Design. Discover. Generate. - Where AI Brings Your Fakemon to Life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigtuf767joz2kvhg77ltqdwfpz72kfoorg5vtna6hnhpstetd7ogi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

