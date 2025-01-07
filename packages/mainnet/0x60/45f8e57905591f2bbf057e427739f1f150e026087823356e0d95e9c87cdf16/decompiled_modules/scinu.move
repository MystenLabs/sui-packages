module 0x6045f8e57905591f2bbf057e427739f1f150e026087823356e0d95e9c87cdf16::scinu {
    struct SCINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCINU>(arg0, 6, b"SCINU", b"Scam Inu", x"7363616d20496e752c20746865207363616d6d657220646f67206f66205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K3_HE_Jo_X5_400x400_1_4e513a30e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

