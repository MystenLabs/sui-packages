module 0x64c70688a7fbd2a8a06d13053b6d3aeac2ac1158065a61f53d7ac51381ab9560::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 9, b"DOGEFATHER", b"DOGE FATHER ", b"Elon the DOGEFATHER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71e0b9eac41e9875b926407faca1bef6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

