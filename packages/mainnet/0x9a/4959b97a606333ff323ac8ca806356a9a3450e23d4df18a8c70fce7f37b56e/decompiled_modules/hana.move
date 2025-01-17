module 0x9a4959b97a606333ff323ac8ca806356a9a3450e23d4df18a8c70fce7f37b56e::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"Hana", b"HANA", x"412062656175746966756c20776176652068617320656d65726765642066726f6d205355492c206d61726b696e672074686520626567696e6e696e67206f662061206a6f75726e657920746f776172647320746865206675747572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737143446831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

