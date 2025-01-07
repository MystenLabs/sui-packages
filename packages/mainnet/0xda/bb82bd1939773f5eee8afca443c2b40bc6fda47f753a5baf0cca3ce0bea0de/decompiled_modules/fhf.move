module 0xdabb82bd1939773f5eee8afca443c2b40bc6fda47f753a5baf0cca3ce0bea0de::fhf {
    struct FHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHF>(arg0, 6, b"FHF", b"fck Hop Fun", b"FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL, Its already a CTO . No socials incoming im annoyed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FHP_81fd8296ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

