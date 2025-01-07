module 0x6fe5cb9226701a091a3e3683e2b73e056a476a65a3a0a3f67aa811d1149974b9::aidogs {
    struct AIDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGS>(arg0, 6, b"AIDOGS", b"AIDogs", b" $AIDOGS Meme Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXRT_14_HWQAA_Krc_K_9685a0fc9c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

