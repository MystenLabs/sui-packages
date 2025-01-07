module 0x849ca08c42ce3c132c7e0c3934dd2186f00bee07ad551d64a1fe1cc2beb92fba::brng {
    struct BRNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRNG>(arg0, 6, b"BRNG", b"BARONGSUI", b"MAKE you scare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054592_13bd604741.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

