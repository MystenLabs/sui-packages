module 0x3110bda20121e4b5311e72f9db7b11e9147ed4e65191a8acabba4012133ffd62::suipa {
    struct SUIPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPA>(arg0, 6, b"SUIPA", b"SUI LIPA", x"537569204c697061202d202254686572652773206e6f7468696e67206c696b6520612072656672657368696e67207377696d20696e207468652073656120746f20636c65617220796f7572206d696e6420616e6420696e7669676f7261746520796f75722073656e7365732e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUALIPA_72bae80039.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

