module 0x87f621218e3cebf976bdbfe665c44e5156df38d1068b16c36584eae9ad738cf8::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 6, b"SOC", b"octopus cook", b"octopus cook on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_07_53_00_ad7660c44d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

