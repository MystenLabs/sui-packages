module 0xbfbaef2529d025a523db1f489bfca2d28c305bbd819e5d96bc1a65bf56e1652b::vfi {
    struct VFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFI>(arg0, 6, b"VFI", b"Vital Few Individuals", b"VFI symbolizes the elite group that shapes the future, making it the go-to asset for those seeking transformative change in finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051988_64637146d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

