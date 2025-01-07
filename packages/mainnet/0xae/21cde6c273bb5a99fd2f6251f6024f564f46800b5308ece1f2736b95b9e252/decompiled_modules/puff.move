module 0xae21cde6c273bb5a99fd2f6251f6024f564f46800b5308ece1f2736b95b9e252::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"FUGU", x"4a7573742061206c6974746c652070756666657266697368206d616b696e6720776176657320f09f8c8a205075666620757020796f7572206578636974656d656e7420616e64206469766520696e746f2074686520646570746873207769746820757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955549763.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

