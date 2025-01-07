module 0x61ab68a83dfb115c4f595937e530f69dee01c5095b8dfd3a66bfc9a061f6720c::secsui {
    struct SECSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECSUI>(arg0, 9, b"SecSUI", b"Second SUI", b"second birthday of Sui. An Suimazing Event", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e12cc9769839355630177df1835a4f1bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

