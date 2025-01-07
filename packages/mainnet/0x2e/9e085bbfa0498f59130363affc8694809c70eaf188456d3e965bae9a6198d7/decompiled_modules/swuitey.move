module 0x2e9e085bbfa0498f59130363affc8694809c70eaf188456d3e965bae9a6198d7::swuitey {
    struct SWUITEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWUITEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWUITEY>(arg0, 6, b"SWUITEY", b"Swuitey", b"The Sweetest Dog On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_07_at_1_19_26_PM_327de47c36.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWUITEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWUITEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

