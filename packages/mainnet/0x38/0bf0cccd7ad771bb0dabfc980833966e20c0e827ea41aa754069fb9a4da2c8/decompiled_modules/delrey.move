module 0x380bf0cccd7ad771bb0dabfc980833966e20c0e827ea41aa754069fb9a4da2c8::delrey {
    struct DELREY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELREY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELREY>(arg0, 6, b"DELREY", b"DelRey OnSui", b"$DELREY, Maye Musk's Beloved Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z9_Mu_G_Gy5_400x400_56a6fc639d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELREY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELREY>>(v1);
    }

    // decompiled from Move bytecode v6
}

