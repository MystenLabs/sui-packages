module 0xfc59c72cc77ae060a4fb8dc334c92f59cd1838e91ffa134476259586504f2a34::trumpina {
    struct TRUMPINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPINA>(arg0, 6, b"TRUMPINA", b"The Trumpina Tor ", b"The Trumpina Tor - Came with me if you want to moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994121731.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPINA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPINA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

