module 0x6b5bf465c21eb0c7b866d1212740441e36d01c8e92660ba9e82726fe05c83c0::usdr {
    struct USDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDR>(arg0, 6, b"USDR", b"USDC REWARD", b"USDR - USDC REWARD EVERY 5 Minute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihzauvauoslu3siaohkbpr5adsgj2ajdhakwvqh426sow4l3s25ca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

