module 0x8011a0a2b8a6e0f74802888b476ef60c98ac6ecbf9ed6f4c954900e7cf146ccd::flahe {
    struct FLAHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAHE>(arg0, 6, b"FLAHE", b"FLAME HEARTH", b"FLAME HEARTH FLAME HEARTH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqdde3chf46jdoigzylq43ozls3bwvdz2luhv5jz54srbtupmsly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLAHE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

