module 0x5aa95eacb297f9acf92b1700fe98b2dc4ea8aeb7d78443078137c09bb97443f9::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"Fight", b"Fighting", b"The first Trump concept coin on the SUI chain. let us fight for trump, fight for maga, fight for America!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241012204741_60f1872baf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

