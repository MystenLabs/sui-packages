module 0x1cde5baa677ea0afe19ba6d9e8fd4f370f1b5eec85fe169a93c9bc4a48d4a5a4::fwendy {
    struct FWENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWENDY>(arg0, 6, b"FWENDY", b"FwendyonSui", x"244657454e4459202d204769726c206d656d65636f696e2c20626f726e206f7574206f6620612066656d616c6520617274697374207468617420676f74207275676765642e20496e7370697265642062792074686520426f79277320436c7562206f66200a404d6174745f46757269650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zk_HH_Nzbt_400x400_6c2eeaa03a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

