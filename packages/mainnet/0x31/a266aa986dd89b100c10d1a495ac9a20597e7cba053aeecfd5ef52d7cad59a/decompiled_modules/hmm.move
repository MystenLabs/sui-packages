module 0x31a266aa986dd89b100c10d1a495ac9a20597e7cba053aeecfd5ef52d7cad59a::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMM>(arg0, 6, b"HMM", b"suiHMM", b"hmmmmmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2u2_AX_1n_W_400x400_326665b2da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

