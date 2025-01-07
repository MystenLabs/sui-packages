module 0x1c1d7727af9796d8b134ab182d57a9ece847784f3f54343f1dee8573c1066297::suiguard {
    struct SUIGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUARD>(arg0, 6, b"SUIGUARD", b"SUI GUARD (BOT)", b"The Sui Guard Wallet is designed to enhance user experience on the Sui blockchain by providing a secure and efficient way to manage digital assets. It offers features such as easy access to decentralized applications (dApps), seamless transactions, and robust security .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3951_f2a1d0223e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

