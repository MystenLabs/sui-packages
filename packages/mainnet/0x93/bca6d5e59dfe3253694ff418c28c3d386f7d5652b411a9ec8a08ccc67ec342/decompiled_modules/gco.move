module 0x93bca6d5e59dfe3253694ff418c28c3d386f7d5652b411a9ec8a08ccc67ec342::gco {
    struct GCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCO>(arg0, 9, b"GCO", b"Ghost Coin", b"For all the ghost out there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e5948f59bc99927f2a86bacb7ffedc63blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

