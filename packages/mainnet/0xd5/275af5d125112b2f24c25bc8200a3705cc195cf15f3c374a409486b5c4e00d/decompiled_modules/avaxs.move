module 0xd5275af5d125112b2f24c25bc8200a3705cc195cf15f3c374a409486b5c4e00d::avaxs {
    struct AVAXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAXS>(arg0, 9, b"AVAXS", b"AVAX SUI", b"AVAX SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/47ff266f11123ba9e065d1baab4c2d1dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVAXS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAXS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

