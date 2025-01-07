module 0x6a889935f55ffbf5bb75efaada8450e7c3488316d0edb837be5304aa0e645cc0::sbabys {
    struct SBABYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBABYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBABYS>(arg0, 6, b"SBABYS", b"Sui Babys", b"Sui babys NFT Collection and stuff animals are coming soon! Socials will be updated on movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5955_c623b4fa8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBABYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBABYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

