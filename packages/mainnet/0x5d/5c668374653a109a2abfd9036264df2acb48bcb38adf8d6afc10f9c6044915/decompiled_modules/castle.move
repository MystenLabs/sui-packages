module 0x5d5c668374653a109a2abfd9036264df2acb48bcb38adf8d6afc10f9c6044915::castle {
    struct CASTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTLE>(arg0, 9, b"CASTLE", b"Em Thanh dep zai", b"Em Thanh dep zai vai ca loz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fe9afb89fcbabf1c6d1bb60785fc7a02blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

