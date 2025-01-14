module 0xff6dca82e8e1afa2bba73390ff49017cb7e3e347c926b935ab6749196ea4039c::friedberg {
    struct FRIEDBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEDBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEDBERG>(arg0, 9, b"friedberg", b"friedberg", b"goldsteinn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRIEDBERG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEDBERG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIEDBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

