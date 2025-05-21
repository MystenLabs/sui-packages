module 0x4ceced674aaa1fcb4a987ef28f2ae67565ef707c177273a4b4c47e8ec387cec0::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"Habibi Germany", b"The only real refugee coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqdloh4shrmq6dczqeh66ju2kk63x3e7s4z7r454uewm7ufeew5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HABIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

