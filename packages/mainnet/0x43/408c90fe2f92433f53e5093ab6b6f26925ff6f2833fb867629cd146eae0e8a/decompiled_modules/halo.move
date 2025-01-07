module 0x43408c90fe2f92433f53e5093ab6b6f26925ff6f2833fb867629cd146eae0e8a::halo {
    struct HALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALO>(arg0, 6, b"HALO", b"HaloHash Media", b"A Multi-Chain AI Gen NFT Marketplace by Creatives for Creatives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/halo_logo_5da8968cc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

