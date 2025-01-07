module 0x67fb48fa7d69e0a370061355d64f2e44bac422aed789323b43ee11b04811858b::rickey {
    struct RICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKEY>(arg0, 6, b"RICKEY", b"Rickey On Sui", b"First Rickey On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_7_8233726494_13cae5c53d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

