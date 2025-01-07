module 0x638803dedcdee0a92c8db6d50e13775c94c5b9480f3f0b64928c87d6b106189a::wifhat {
    struct WIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHAT>(arg0, 6, b"WIFHAT", b"SuiwifHatonSui", b"New meme Coin On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_171024_d9b11f9e9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

