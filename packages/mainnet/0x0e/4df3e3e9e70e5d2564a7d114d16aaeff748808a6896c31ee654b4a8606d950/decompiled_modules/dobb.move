module 0xe4df3e3e9e70e5d2564a7d114d16aaeff748808a6896c31ee654b4a8606d950::dobb {
    struct DOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBB>(arg0, 9, b"DOBB", b"Double Bobble", b"sweet double bobbles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b23126a85b23f1f89167d66c49fd8266blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

