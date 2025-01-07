module 0x261e48278894ae215b3b2361731de77918286912e31d02cec78a9f6b2ba8fe0b::ox1 {
    struct OX1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OX1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OX1>(arg0, 6, b"OX1", b"Sui Pay", b"Use your existing USDC balance or swap another asset for USDC to complete your purchase with near-zero fees and sub-second finality ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd6_DU_Zbb_YA_An5_Dx_2a509d15f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OX1>>(v1);
    }

    // decompiled from Move bytecode v6
}

