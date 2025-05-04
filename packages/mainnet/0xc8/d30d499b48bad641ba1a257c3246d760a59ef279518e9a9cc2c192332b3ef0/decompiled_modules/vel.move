module 0xc8d30d499b48bad641ba1a257c3246d760a59ef279518e9a9cc2c192332b3ef0::vel {
    struct VEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEL>(arg0, 9, b"VEL", b"veloncity", b"Velocity Token (VT) is a digital asset on the Sui blockchain, specifically focused on speed and efficiency. It aims to provide fast, secure, and seamless transactions by leveraging Sui's advanced technology. Velocity Token aims to be a high-performance digital currency in the decentralized ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/10ea9b571055003922b378c55ef18bfbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

