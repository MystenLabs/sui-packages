module 0x5631c442ccd869c4a7151bd9ee1c169db92c8f7050902f895f08b40600a23afc::hava {
    struct HAVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAVA>(arg0, 6, b"HAVA", b"HAVA SUI", x"4861766120686164206265656e20776f726b696e6720617320612070697a7a612064656c69766572792067757920666f72206a757374206f7665722061207965617220616e6420736c6f776c79206d616e6167656420746f207361766520736f6d65206d6f6e65792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wh3zo_VUB_400x400_ef0d91fd36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

