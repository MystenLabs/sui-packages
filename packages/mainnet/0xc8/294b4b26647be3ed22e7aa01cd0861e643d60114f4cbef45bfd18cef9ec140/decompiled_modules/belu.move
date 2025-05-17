module 0xc8294b4b26647be3ed22e7aa01cd0861e643d60114f4cbef45bfd18cef9ec140::belu {
    struct BELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELU>(arg0, 6, b"Belu", b"BelugaOnSui", b"Beluga On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsvpktgx7ziszf6oqq67apzymk5zanor7zqt7zkdbsgf5devx5bi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BELU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

