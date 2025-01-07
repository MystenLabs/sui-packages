module 0x38c41caa99a1e767f9436b60a5ce7be73d6c70d4f4b1e6a6048b90277cb0cd85::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 6, b"SUIGMA", b"Sigma on Sui", b"Are you swimming with the sharks or drifting with the minnows?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pasted_Graphic_15_db3fdca145.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

