module 0x4b714d1d602ba5af1e16262367d9719a8d5497ff2deec34149050be43dfc2f2c::smolsui {
    struct SMOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLSUI>(arg0, 6, b"SmolSui", b"Smol SUI", b"unofficial official meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xm_Crdg_Lu_400x400_b6df913cf5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

