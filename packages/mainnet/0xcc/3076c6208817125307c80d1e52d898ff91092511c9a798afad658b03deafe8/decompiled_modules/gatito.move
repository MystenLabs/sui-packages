module 0xcc3076c6208817125307c80d1e52d898ff91092511c9a798afad658b03deafe8::gatito {
    struct GATITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATITO>(arg0, 6, b"GATITO", b"GATITO ON SUI", x"47415449544f204d4f564553204f56455220544f2053554920536f6369616c732077696c6c20626520757064617465642076696120636f6d6d656e74732077652077696c6c2067657420626f6f7374696e6720616e64207472656e64696e6720636f6d65206a6f696e20757320656e6a6f79206861766520736f6d652066756e20616e64206d6f737420696d706f7274616e746c79206c65747320626f6e64207468697321210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gatito_sui_716950d946_9fa071c68d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

