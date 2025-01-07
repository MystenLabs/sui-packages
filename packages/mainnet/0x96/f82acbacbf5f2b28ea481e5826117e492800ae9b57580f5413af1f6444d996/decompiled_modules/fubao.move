module 0x96f82acbacbf5f2b28ea481e5826117e492800ae9b57580f5413af1f6444d996::fubao {
    struct FUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBAO>(arg0, 6, b"Fubao", b"Fubao ", b"The very first and ONLY panda on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954509691.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUBAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

