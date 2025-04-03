module 0x7b214dad6f1571d41758703a41db5473b0940efb5900d0bade22920a56b45c6c::zftru {
    struct ZFTRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFTRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFTRU>(arg0, 9, b"ZFTRU", b"jyrtw", b"sygoe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54f71cfdc2a7730c8e380c453fe14e0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFTRU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFTRU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

