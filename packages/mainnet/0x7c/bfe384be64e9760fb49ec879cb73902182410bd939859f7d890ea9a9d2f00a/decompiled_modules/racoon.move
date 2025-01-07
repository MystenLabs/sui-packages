module 0x7cbfe384be64e9760fb49ec879cb73902182410bd939859f7d890ea9a9d2f00a::racoon {
    struct RACOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACOON>(arg0, 6, b"RACOON", b"RACOON RACHOP", x"57697468206d792062756e6e79206279206d7920736964652c20526163686f7020616e6420492074616b652074686520726964652c0a4f6e206c6f6e67206a6f75726e65797320776520676c6964652c207468726f75676820235355492c206f757220647265616d7320636f6c6c6964652120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4118_fd5c2e4b2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

