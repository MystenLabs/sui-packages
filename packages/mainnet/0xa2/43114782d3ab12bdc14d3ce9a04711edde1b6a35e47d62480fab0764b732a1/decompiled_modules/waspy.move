module 0xa243114782d3ab12bdc14d3ce9a04711edde1b6a35e47d62480fab0764b732a1::waspy {
    struct WASPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASPY>(arg0, 6, b"Waspy", b"Waspy the sui wasp", b"Be careful the waspy sting could cause serious wins and 100x!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZZ_Zzz_f161164516.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

