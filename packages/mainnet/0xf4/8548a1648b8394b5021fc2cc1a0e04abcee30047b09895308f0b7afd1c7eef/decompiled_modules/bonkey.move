module 0xf48548a1648b8394b5021fc2cc1a0e04abcee30047b09895308f0b7afd1c7eef::bonkey {
    struct BONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKEY>(arg0, 6, b"BONKEY", b"Bonkey On Sui", b"Matt Furie creation $BONKEY on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_11_20_39_01_56e799cde4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

