module 0x9d3a88a7a7c625bbf99649b4c8c3262f16dc91906845d5078dd69cc76c7792db::pepe_usa {
    struct PEPE_USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_USA>(arg0, 9, b"PepeUS", b"Pepe Usa", b"pepe us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775668608223-d0760b21f00bfdc0bfc20007cb734dd6.jpeg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE_USA>>(0x2::coin::mint<PEPE_USA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_USA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_USA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

