module 0x51572b566351c8dc2a7c09105cf2fb96f43b035fe9bbfedff4a3ec0cdb2656f4::ugo {
    struct UGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGO>(arg0, 6, b"UGO", b"YUGIOH", b"the official coin of Yu-Gi-Oh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigi7gftg54l3akvje7jgxgp7vaeiz7l5vxiw54p7fj7mmosf33yxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

