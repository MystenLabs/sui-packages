module 0x49db6dc89c30b0684ab474c6e7b0643a4adb2305ebed94b62fea54d6ed74b19c::sewe {
    struct SEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWE>(arg0, 6, b"SEWE", b"SEWEY", b"Itz Sewey. Yu know, te blockchan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000162752_4f668bdce8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

