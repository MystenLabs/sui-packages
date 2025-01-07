module 0xbe09ed7c7e29838af4ae0ee4567737259177ce85ad58a02b4d9fdcff4229fee8::suiking {
    struct SUIKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKING>(arg0, 6, b"SUIKING", b"Sui King POSEIDON", x"706f736569646f6e736f6c6f66660a41646d6972652074686520706f776572206f6620506f736569646f6e24504f534549444f4e206f6e206d6f766570756d700a204c697374696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8291_e608d3f0ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

