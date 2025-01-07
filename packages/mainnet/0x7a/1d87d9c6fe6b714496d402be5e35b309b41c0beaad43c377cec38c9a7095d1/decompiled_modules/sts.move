module 0x7a1d87d9c6fe6b714496d402be5e35b309b41c0beaad43c377cec38c9a7095d1::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"SUI TRUMP the second", x"535549205452554d502028546865207365636f6e642920776520676f7420706c616e7320666f722061206c6f6e67207465726d2072756e0a0a446f6e616c64205472756d70204d656d6520546f6b656e2c2077686572652062696720647265616d7320616e6420626967676572206d656d657320636f6d6520746f6765746865722120496e7370697265642062792074686520756e706172616c6c656c6564206368617269736d61206f6620446f6e616c64205472756d702c2077657265206865726520746f206d616b652063727970746f20677265617420616761696e206f6e2074686520537569206e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5198_69e7baaf36.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STS>>(v1);
    }

    // decompiled from Move bytecode v6
}

