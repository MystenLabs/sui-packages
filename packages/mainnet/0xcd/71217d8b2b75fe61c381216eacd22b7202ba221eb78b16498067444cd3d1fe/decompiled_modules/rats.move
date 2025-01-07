module 0xcd71217d8b2b75fe61c381216eacd22b7202ba221eb78b16498067444cd3d1fe::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 0, b"RATS", b"RATS", b"RATS Create by bitsui.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cloudflare-ipfs.com/ipfs/QmRZ6pkCuZkwGKrTfe6gLrTSkVX1fzERzc5Dk55QL6FHub")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATS>>(v1);
        0x2::coin::mint_and_transfer<RATS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RATS>>(v2);
    }

    // decompiled from Move bytecode v6
}

