module 0x265588e5558d9767587d00b4a8766ca320a19057788fa42277af2099ba6319be::hua {
    struct HUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUA>(arg0, 6, b"Hua", b"Kinghuahua", b"Hail to the Chihuahua king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731086655593.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

