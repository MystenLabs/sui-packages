module 0x73e09d638ccd0493bec31bc7d00689c55724385d7505e0b0eb37d27d7863bdb9::efrdss {
    struct EFRDSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFRDSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFRDSS>(arg0, 6, b"EFRDSS", b"frsfds", b"dqdqsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyqax22ci5it63nng4gcnvk3ocvp7eeou4beoiy7vi34campwyzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFRDSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EFRDSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

