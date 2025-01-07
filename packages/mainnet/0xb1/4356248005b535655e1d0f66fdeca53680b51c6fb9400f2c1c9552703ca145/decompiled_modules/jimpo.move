module 0xb14356248005b535655e1d0f66fdeca53680b51c6fb9400f2c1c9552703ca145::jimpo {
    struct JIMPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMPO>(arg0, 6, b"Jimpo", b"Jimpo Sui", b"$Jimpo is created by a decentralized team of builders on Sui : $Jimpo is for the people and by the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jimpo_d9740e14e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIMPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

