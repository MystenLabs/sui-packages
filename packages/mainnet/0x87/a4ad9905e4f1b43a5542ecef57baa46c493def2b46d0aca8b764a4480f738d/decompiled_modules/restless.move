module 0x87a4ad9905e4f1b43a5542ecef57baa46c493def2b46d0aca8b764a4480f738d::restless {
    struct RESTLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESTLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESTLESS>(arg0, 6, b"RESTLESS", b"Restless Token", x"4e6f742063757272656e746c7920616666696c6961746564207769746820526573746c65737320537069726974732064697374696c6c696e67206c6f636174656420696e204e6f727468204b616e73617320436974792c204d6973736f7572692e2e20594554213f20f09f9180", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1773391814157.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESTLESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESTLESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

