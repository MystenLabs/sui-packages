module 0x9ee70d749cffd27f8555a025042c0c7e99e679c49f5e8dcedd95fba89d048e24::wc {
    struct WC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WC>(arg0, 6, b"WC", b"Wrapped Cat", b"Wrapped Cat is a charming meme token on the SUI blockchain, featuring an adorable cat cozily wrapped in paper like a burrito. Join the Wrapped Cat community for warm vibes and rewarding experiences!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_c1b97ea0fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WC>>(v1);
    }

    // decompiled from Move bytecode v6
}

