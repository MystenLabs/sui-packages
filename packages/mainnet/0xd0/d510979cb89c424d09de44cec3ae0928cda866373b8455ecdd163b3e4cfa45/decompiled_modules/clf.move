module 0xd0d510979cb89c424d09de44cec3ae0928cda866373b8455ecdd163b3e4cfa45::clf {
    struct CLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLF>(arg0, 6, b"CLF", b"Cooler Fishing", b"If it works it works", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cooler_fishing_d379c82ebe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

