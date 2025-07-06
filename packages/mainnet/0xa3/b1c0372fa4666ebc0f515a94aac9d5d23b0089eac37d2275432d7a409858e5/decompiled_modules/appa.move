module 0xa3b1c0372fa4666ebc0f515a94aac9d5d23b0089eac37d2275432d7a409858e5::appa {
    struct APPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPA>(arg0, 6, b"APPA", b"Appa On Sui", b"10tons flying bison", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhpaqi6jkvck3qfeome3hpnilgqb74i7nktj4gzxaek6pdg6zeka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

