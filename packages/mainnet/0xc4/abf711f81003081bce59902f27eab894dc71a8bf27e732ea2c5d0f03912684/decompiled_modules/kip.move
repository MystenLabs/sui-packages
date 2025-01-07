module 0xc4abf711f81003081bce59902f27eab894dc71a8bf27e732ea2c5d0f03912684::kip {
    struct KIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIP>(arg0, 6, b"KIP", b"Kipland Dynamite", x"5765206d657420696e2061206368617420726f6f6d0a6e6f77206f7572206c6f76652063616e2066756c6c7920626c6f6f6d0a737572652074686520776f726c642077696465207765622069732067726561740a62757420796f752c20796f75206d616b65206d652073616c69766174650a5965732c2049206c6f766520746563686e6f6c6f67790a627574206e6f74206173206d75636820617320796f752c20796f75207365650a6275742049207374696c6c206c6f766520746563686e6f6c6f67790a0a416c7761797320616e6420666f7265766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731021061626.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

