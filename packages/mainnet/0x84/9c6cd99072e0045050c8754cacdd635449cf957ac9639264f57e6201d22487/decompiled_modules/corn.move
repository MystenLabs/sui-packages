module 0x849c6cd99072e0045050c8754cacdd635449cf957ac9639264f57e6201d22487::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"CORN", b"SUICORN", b"Sui was built for s, so we made one. Join Soly and $CORN labs as we push the limits of 3D and AR content in Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Iz_V_Tb_C8_400x400_f825042bda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

