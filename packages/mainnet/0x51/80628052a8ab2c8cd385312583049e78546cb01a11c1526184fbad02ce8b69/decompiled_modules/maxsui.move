module 0x5180628052a8ab2c8cd385312583049e78546cb01a11c1526184fbad02ce8b69::maxsui {
    struct MAXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXSUI>(arg0, 9, b"MAXSUI", b"SUI MAXIMUS", b"HERO FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5e76dfd5a544a1e489d65b7f1baca5b3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

