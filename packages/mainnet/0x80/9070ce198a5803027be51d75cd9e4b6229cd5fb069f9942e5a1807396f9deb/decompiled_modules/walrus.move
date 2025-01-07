module 0x809070ce198a5803027be51d75cd9e4b6229cd5fb069f9942e5a1807396f9deb::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"Walrus", b"Walrus on Sui", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized. Now on Devnet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cnn_5_Kz_C_400x400_45019ad30f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

