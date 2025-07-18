module 0xe5de6d13f45c051e728682899c5a7a02d07e1ca95c6b7077ad3f34533d3768cd::pige {
    struct PIGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGE>(arg0, 6, b"PIGE", b"Pigeon", b"Pigeon delivers without hesitation in blocks that know how to fly. In the ecosystem it is king of the sky with the Sui logo on the ring of its hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqfs3f5zcgpiwspp5bwy3ldd6rgxk2mjsiedcx4agscuqqpj3g2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

