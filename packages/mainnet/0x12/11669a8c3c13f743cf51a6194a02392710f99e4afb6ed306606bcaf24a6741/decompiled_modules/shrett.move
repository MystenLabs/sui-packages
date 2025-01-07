module 0x1211669a8c3c13f743cf51a6194a02392710f99e4afb6ed306606bcaf24a6741::shrett {
    struct SHRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRETT>(arg0, 6, b"SHRETT", b"Shrett the Shark", b"Shrett the Shark, has gotten lost in the great white sea in Sui. Help him get back to his family. JOIN TG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrett_7336e07009.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

