module 0x6219d75cd4ea9cb9cbd4449a27ec401689e5e9c3d01381e93fdfc2867e3cdc31::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shiba Inu", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/402202d7-b413-4bf9-b3e6-75dc14700031.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

