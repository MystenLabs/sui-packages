module 0x2a0cb5701f0d7782989220a8f8f333e42cf7e387ef2919727c962195a64bb636::dexter {
    struct DEXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEXTER>(arg0, 6, b"Dexter", b"dexterOnSui", x"446546692061696e277420676f6e6e6120446546414920697473656c66200a54616c6b20746f206d653a2068747470733a2f2f636861742e64657874657261692e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049377_bf86ae7ea1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEXTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

