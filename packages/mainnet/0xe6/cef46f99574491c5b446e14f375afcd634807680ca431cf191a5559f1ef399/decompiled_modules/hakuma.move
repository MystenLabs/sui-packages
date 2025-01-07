module 0xe6cef46f99574491c5b446e14f375afcd634807680ca431cf191a5559f1ef399::hakuma {
    struct HAKUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAKUMA>(arg0, 6, b"HAKUMA", b"Hakuma on Sui", x"54686520746f6b656e20746861742063616d6520746f2073657420796f7520667265652066726f6d20776f7272696573206665656c206672656520746f20696e7665737420696e2048616b756d612e2045766572797468696e672077696c6c2062652066696e652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735734418212.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAKUMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKUMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

