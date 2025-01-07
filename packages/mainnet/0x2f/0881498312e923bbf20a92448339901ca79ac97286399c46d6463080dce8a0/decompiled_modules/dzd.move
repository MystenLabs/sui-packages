module 0x2f0881498312e923bbf20a92448339901ca79ac97286399c46d6463080dce8a0::dzd {
    struct DZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DZD>(arg0, 6, b"DZD", b"Algerian dinar", b"the Algerian dinar has always been a memcoin in reality and it will always be, you will find it only on SUI to trade it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732192841545.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DZD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DZD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

