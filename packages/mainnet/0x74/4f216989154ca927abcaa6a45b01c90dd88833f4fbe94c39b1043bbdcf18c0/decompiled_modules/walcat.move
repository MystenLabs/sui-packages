module 0x744f216989154ca927abcaa6a45b01c90dd88833f4fbe94c39b1043bbdcf18c0::walcat {
    struct WALCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALCAT>(arg0, 6, b"WALCAT", b"Walrus Cat", b"I just uploaded my cat's pics on Walrus lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736243756380.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

