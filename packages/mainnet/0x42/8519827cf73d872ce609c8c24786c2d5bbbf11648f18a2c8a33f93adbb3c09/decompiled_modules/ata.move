module 0x428519827cf73d872ce609c8c24786c2d5bbbf11648f18a2c8a33f93adbb3c09::ata {
    struct ATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATA>(arg0, 6, b"ATA", b"Ata Virtuals by SuiAI", x"5573686572696e6720696e2061206e65772077617665206f66206469676974616c20636f6d6d6572636520f09f8c8a207c20506f776572656420627920414920696e6e6f766174696f6e20f09fa7a0207c204c6f79616c20746f206f757220636f6d6d756e69747920f09f90be205768656e206974e28099732064696e6e65722074696d652c207468652077686f6c65207061636b20656174732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f_Jsa_G_Jc6_400x400_b9a1b426c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

