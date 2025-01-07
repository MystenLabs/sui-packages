module 0x3cc0fb1e30a9d197b6bf81e1a4af0ad630c6890dd887cfcd792de028b97e7233::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"Bruce Lee on Sui", x"244252554345206368616e6e656c732074686520737069726974206f66206d61727469616c2061727473206d617374657279206f6e2074686520537569204e6574776f726b2e204167696c652c20706f77657266756c2c20616e64207072656369732e2042652077617465722c206d7920667269656e642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_8bf620920c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

