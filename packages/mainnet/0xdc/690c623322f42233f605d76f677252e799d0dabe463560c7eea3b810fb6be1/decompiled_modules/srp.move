module 0xdc690c623322f42233f605d76f677252e799d0dabe463560c7eea3b810fb6be1::srp {
    struct SRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRP>(arg0, 6, b"SRP", b"SuiGuardProtection", b"SRO is specifically designed to be a security in the sui network, using innovative and advanced security methods.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_House_Real_Estate_Logo_20250507_042712_0000_034403ac6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

