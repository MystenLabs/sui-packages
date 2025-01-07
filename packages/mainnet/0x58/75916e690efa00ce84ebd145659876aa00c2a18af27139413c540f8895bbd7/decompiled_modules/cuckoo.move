module 0x5875916e690efa00ce84ebd145659876aa00c2a18af27139413c540f8895bbd7::cuckoo {
    struct CUCKOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCKOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCKOO>(arg0, 9, b"CUCKOO", b"Cuckoo Token", b"Cuckoo is a friend of mankind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48e61e0c335f8f8f29cca79946b87577blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCKOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCKOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

