module 0xc19474b9625d1e94aeb3a83f9c02d178a10a39265e5f6c1af2226a75b399874d::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 6, b"TADPOLE", b"TAD POLE", x"426173656420737061776e206f6620506570652e2057652061726520746865206f6666696369616c20616d7068696269616e206d6173636f74206f6620426173652e200a4c69746572616c6c792c206a757374206120746164706f6c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_M0_QW_9o5_400x400_1d713ec25e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

