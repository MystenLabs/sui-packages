module 0x926ba52545165b5afd558edd5719dc984eebccd9233963791b9df6dbb335532f::deadpoolsui {
    struct DEADPOOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADPOOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADPOOLSUI>(arg0, 6, b"DeadPoolSui", b"DeadPool", b"The 1st DeadPool on the Sui Network!  I took some time today to create the Telegram and the website.   I am hoping to do well here.  Join the Telegram!  The VC is open! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_T0c_FOVQ_400x400_69d5804092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADPOOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEADPOOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

