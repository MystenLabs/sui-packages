module 0x8807f1d7167bb7faf391b3a69314b41c0652dde89ff06b79e695116b21b846eb::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"Suinami", b"Sui Nami LoL", b"Nami is the Queen of Support in League of Legends (LoL). She deserves to be queen of SUI chain as well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nami_0_e835f6d670.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

