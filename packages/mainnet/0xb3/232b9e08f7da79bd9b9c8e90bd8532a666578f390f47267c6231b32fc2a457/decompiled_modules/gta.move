module 0xb3232b9e08f7da79bd9b9c8e90bd8532a666578f390f47267c6231b32fc2a457::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 6, b"GTA", b"GTA On Sui", b"Experience the ultimate blockchain gaming revolution on the lightning-fast Sui Network. Where crime pays in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiajj6chxpu4m2um6nshjioywepeagyhaflnnwvbbr5fkh6577mjou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

