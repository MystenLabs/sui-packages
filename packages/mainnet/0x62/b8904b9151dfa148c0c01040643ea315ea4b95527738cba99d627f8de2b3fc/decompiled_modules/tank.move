module 0x62b8904b9151dfa148c0c01040643ea315ea4b95527738cba99d627f8de2b3fc::tank {
    struct TANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANK>(arg0, 6, b"TANK", b"tank", b"this is test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreicir5prz4dlvvni63did2nf2ffrgr7kcki6ukbqkgyaaeukarkulm?X-Algorithm=PINATA1&X-Date=1736844170&X-Expires=315360000&X-Method=GET&X-Signature=ee7c5267043083cd9d054da7eca2f555d64dbeb7adef62f8f06a25e371d9cd6f")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

