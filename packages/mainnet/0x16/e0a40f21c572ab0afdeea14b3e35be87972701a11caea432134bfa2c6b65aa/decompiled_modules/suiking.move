module 0x16e0a40f21c572ab0afdeea14b3e35be87972701a11caea432134bfa2c6b65aa::suiking {
    struct SUIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKING>(arg0, 6, b"SUIKING", b"SUI KING POSEIDON", x"706f736569646f6e736f6c6f66660a41646d6972652074686520706f776572206f6620506f736569646f6e24504f534549444f4e206f6e20537569204c697374696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8291_e12fcf872e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

