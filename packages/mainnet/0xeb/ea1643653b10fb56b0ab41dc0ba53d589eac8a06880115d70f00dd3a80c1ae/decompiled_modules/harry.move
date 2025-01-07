module 0xebea1643653b10fb56b0ab41dc0ba53d589eac8a06880115d70f00dd3a80c1ae::harry {
    struct HARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRY>(arg0, 6, b"HARRY", b"harry", x"48617272792074686520686967686c616e6420636f77210a0a23312054494b544f4b20434f57", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/harry_44e6734e95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

