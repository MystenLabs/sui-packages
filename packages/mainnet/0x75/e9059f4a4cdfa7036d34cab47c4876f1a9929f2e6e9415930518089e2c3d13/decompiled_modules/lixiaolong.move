module 0x75e9059f4a4cdfa7036d34cab47c4876f1a9929f2e6e9415930518089e2c3d13::lixiaolong {
    struct LIXIAOLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIXIAOLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIXIAOLONG>(arg0, 6, b"Lixiaolong", b"Bruce Lee", b"A generation of grandmasters, famous actors, and eternal kung fu emperors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727881663688_950b97d0af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIXIAOLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIXIAOLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

