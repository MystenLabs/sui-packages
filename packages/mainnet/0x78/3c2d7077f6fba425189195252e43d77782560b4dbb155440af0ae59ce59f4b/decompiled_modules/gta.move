module 0x783c2d7077f6fba425189195252e43d77782560b4dbb155440af0ae59ce59f4b::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 6, b"GTA", b"Grand Theft Auto Sui", b"The streets are heating up , GRAND THEFT AUTO BLASTS INTO SUI with chaos, style, and unstoppable energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiajj6chxpu4m2um6nshjioywepeagyhaflnnwvbbr5fkh6577mjou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

