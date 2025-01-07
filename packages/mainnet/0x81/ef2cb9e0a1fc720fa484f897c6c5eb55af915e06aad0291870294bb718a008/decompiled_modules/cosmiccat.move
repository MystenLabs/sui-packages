module 0x81ef2cb9e0a1fc720fa484f897c6c5eb55af915e06aad0291870294bb718a008::cosmiccat {
    struct COSMICCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMICCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMICCAT>(arg0, 6, b"CosmicCat", b"Cosmic Cat On Sui", b"Cosmic Cat Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cosmic_Cat_60cb6986a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMICCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSMICCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

