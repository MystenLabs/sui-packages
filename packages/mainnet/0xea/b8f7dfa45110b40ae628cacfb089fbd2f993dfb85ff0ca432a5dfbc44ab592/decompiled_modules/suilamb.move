module 0xeab8f7dfa45110b40ae628cacfb089fbd2f993dfb85ff0ca432a5dfbc44ab592::suilamb {
    struct SUILAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMB>(arg0, 6, b"SUILAMB", b"Suilamb", b"SUILAMB on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_15_34_22_0da9b1592d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

