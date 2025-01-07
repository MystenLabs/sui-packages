module 0x6cdb1c3039db0a021980bbbbc984f473230aa72394e4d49584bb1210a8cc0e93::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SUI DEPLOYS", x"496e7374616e7420416c657274732061626f7574206e657720535549207061697273206f6e20426c75656d6f76652c2043657475732c20547572626f732046696e616e63650a2d20416c657274732061626f7574206e6577204d6f766550756d7020636f696e730a0a506f77657265642062792040537569737365416e6e6f7563656d656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000183705_1102fdaec2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

