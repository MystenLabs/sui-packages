module 0xb369784ce080483d8705d49abdeeb4e3e6fce285285e10fb22153b35fb06a220::jun {
    struct JUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUN>(arg0, 9, b"JUN", b"June Token", b"A token for the month of June", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

