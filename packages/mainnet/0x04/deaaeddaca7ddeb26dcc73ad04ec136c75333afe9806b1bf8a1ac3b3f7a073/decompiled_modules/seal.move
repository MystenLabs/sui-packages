module 0x4deaaeddaca7ddeb26dcc73ad04ec136c75333afe9806b1bf8a1ac3b3f7a073::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"seal", b"Hippos are a thing of the past, now it's time for the seals to take the stage!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_C_Ii_UWX_7b69ec5028.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

