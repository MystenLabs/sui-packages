module 0x1f10af5d802ecaa5c7ba56cdeda73d79b5dc3f92ba8378fcbd40583d6b301970::abcdd {
    struct ABCDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCDD>(arg0, 6, b"ABCDD", b"ABCD", b"ASASASASASA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778256589953.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABCDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

