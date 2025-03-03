module 0x999943e01e02b97dc766345fd52ec820b337eed245c6098c054eab034883e564::maske {
    struct MASKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASKE>(arg0, 9, b"MASKE", b"MASKE MASKE", b"A Much Bloodier and Violent Character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a95ce4ee9883f5acace518785edb8f7ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

