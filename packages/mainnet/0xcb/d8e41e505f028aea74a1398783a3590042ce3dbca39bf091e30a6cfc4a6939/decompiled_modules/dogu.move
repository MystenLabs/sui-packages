module 0xcbd8e41e505f028aea74a1398783a3590042ce3dbca39bf091e30a6cfc4a6939::dogu {
    struct DOGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGU>(arg0, 6, b"DOGU", b"Dog Guard Protection", b"Dogu - Cute guard dog on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014329_edc882c359.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

