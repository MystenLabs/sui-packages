module 0xe3d85aa285768c43aa6005fb5aa1c542edf84658eec91a01754cce80d378d4c8::rookie {
    struct ROOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOKIE>(arg0, 6, b"ROOKIE", b"ROOKIE SUI", x"41206e6577207374617220656d657267656420696e207468652063727970746f63757272656e63792067616c617879200a24526f6f6b696521204275696c74206f6e20535549204e4554574f524b2e0a0a526f6f6b69652069736e74206a75737420616e6f74686572206d656d65636f696e2c206974732061206d6f76656d656e742064726976656e20627920612076696272616e7420636f6d6d756e697479206b6e6f776e2061732074686520524f4f4b4552532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvryebg6zw53ad3t3ulk4qb7inra6uc2bnzd3y2dddehammeni2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROOKIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

