module 0x6d72314bef5af1c39c01dc540db12d46fe57fd53060d16fe3f3dfbde6c899419::doolio {
    struct DOOLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOLIO>(arg0, 6, b"DOOLIO", b"DoolioSui", b"Doolio On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Doolio_87422ef793.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOLIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

