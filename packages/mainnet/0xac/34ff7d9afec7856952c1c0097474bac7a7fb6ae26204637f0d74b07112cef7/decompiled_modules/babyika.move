module 0xac34ff7d9afec7856952c1c0097474bac7a7fb6ae26204637f0d74b07112cef7::babyika {
    struct BABYIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYIKA>(arg0, 6, b"BabyIKA", b"Baby IKA", b"Baby of IKA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxnetxl2rzjr77xm3xwsczdtl66gjel22np452dacgxpghktcxpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

