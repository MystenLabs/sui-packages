module 0xac645ef8a1faaab4e08e5ee02601c18ef9c4bd3374bc874bee8c39f9c5284e79::wazobia {
    struct WAZOBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAZOBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAZOBIA>(arg0, 6, b"WAZOBIA", b"WAZOBIA CRYPTO", b"Crypto currency Signal, News & facts , Market Analysis AND Blockchain education", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecejajm4mx7yhbns6ngfqjkzl3xmp5dg3lcxqzxd3gvmi7v2fori")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAZOBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAZOBIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

