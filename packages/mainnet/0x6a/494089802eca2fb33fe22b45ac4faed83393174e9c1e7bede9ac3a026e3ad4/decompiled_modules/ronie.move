module 0x6a494089802eca2fb33fe22b45ac4faed83393174e9c1e7bede9ac3a026e3ad4::ronie {
    struct RONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONIE>(arg0, 9, b"Ronie", b"Saeronie", b"dsfadfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5605c9b910d7904638e335f8cdc55bedblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

