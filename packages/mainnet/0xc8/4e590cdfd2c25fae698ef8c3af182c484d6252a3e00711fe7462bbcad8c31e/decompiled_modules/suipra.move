module 0xc84e590cdfd2c25fae698ef8c3af182c484d6252a3e00711fe7462bbcad8c31e::suipra {
    struct SUIPRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRA>(arg0, 6, b"SUIPRA", b"Bro is That a SUIPRA?", x"54686973206c6174657374204d6f64656c206f7320535549505241204a7573742063616d65206f7574206f662074686520666163746f72792c206974277320746865206272616e64206e65772076313620656e67696e652c20697420686173206120746f70207370656564206f66203530306b6d2f680a49742063616e20776974687374616e642074686520686172736865737420636f6e646974696f6e73207468616e6b7320746f206974732064657369676e0a47657420757273656c66206120535549505241", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGA_342_f6b3fc0813.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

