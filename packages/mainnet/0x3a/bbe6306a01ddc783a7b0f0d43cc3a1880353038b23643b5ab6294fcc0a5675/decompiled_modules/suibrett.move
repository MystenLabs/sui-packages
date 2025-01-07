module 0x3abbe6306a01ddc783a7b0f0d43cc3a1880353038b23643b5ab6294fcc0a5675::suibrett {
    struct SUIBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRETT>(arg0, 6, b"SUIBRETT", b"SUI BRETT", x"546865207665727920666972737420244272657474206f6e2053756920636861696e0a427265747420697320746865206c6567656e64617279206368617261637465722066726f6d204d6174742046757269657320426f79732720636c756220636f6d69632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mkrd8_Gu_Z_400x400_9e2843d9f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

