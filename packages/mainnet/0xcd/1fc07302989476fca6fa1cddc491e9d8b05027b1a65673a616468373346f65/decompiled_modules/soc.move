module 0xcd1fc07302989476fca6fa1cddc491e9d8b05027b1a65673a616468373346f65::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOC>(arg0, 6, b"SOC", b"Seal Cat", b"No socials send it the wif of sui and fits the sui narrative launched of SUILAUNCH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/b60f2fea_5558_40d3_82e0_6292bdaf5977_ca060fcaa6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

