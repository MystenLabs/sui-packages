module 0x3b894c208c64bcdfae972bf42e4bc2fb173bc086a283a1a9d7fe31646bae19a2::hsm {
    struct HSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSM>(arg0, 6, b"HSM", b"Horde SUI Mascot", b"Horde SUI Mascot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_DGO_Lcv_400x400_1_22b2b2916c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

