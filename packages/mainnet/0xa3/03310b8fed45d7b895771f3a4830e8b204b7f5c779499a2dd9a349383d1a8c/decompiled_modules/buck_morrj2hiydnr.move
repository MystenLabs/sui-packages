module 0xa303310b8fed45d7b895771f3a4830e8b204b7f5c779499a2dd9a349383d1a8c::buck_morrj2hiydnr {
    struct BUCK_MORRJ2HIYDNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK_MORRJ2HIYDNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK_MORRJ2HIYDNR>(arg0, 9, b"BUCK", b"TheBigBucks", b"The payment token used for the big bucks club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmVnfZ1wPRqE4TLerxv7G3HYJCWRiu5wJk9xKTiUtiiyVw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK_MORRJ2HIYDNR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK_MORRJ2HIYDNR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

