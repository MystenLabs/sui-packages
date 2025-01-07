module 0x48b23b22f37deba00096bd7346392ccdb6af1d2260fe57161b79717d4227d27a::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"Bloop", b"BLOOP", b"Welcome to Bloop, a revolutionary memecoin built on the SUI network. Inspired by the mysterious sound believed to come from a gigantic sea creature, Bloop symbolizes power, influence, and innovation in the world of crypto. Get ready to dive into the next big wave in the crypto world and become part of something bigger than ever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241027_184739_0e4c4f39f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

