module 0x44cc63754c521cd38d20e1f3714fb34778ea74f1a531661a7ae2e31349b70e9c::gatitui {
    struct GATITUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATITUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATITUI>(arg0, 6, b"GATITUI", b"GATITO SUI", x"47415449544f204d4f564553204f56455220544f205355490a0a536f6369616c732077696c6c20626520757064617465642076696120636f6d6d656e74730a0a77652077696c6c2067657420626f6f7374696e6720616e64207472656e64696e670a0a636f6d65206a6f696e20757320656e6a6f79206861766520736f6d652066756e20616e64206d6f737420696d706f7274616e746c79206c65747320626f6e6420746869732121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gatito_sui_716950d946.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATITUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATITUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

