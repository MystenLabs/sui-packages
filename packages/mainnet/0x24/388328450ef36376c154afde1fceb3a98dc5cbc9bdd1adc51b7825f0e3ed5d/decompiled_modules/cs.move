module 0x24388328450ef36376c154afde1fceb3a98dc5cbc9bdd1adc51b7825f0e3ed5d::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 9, b"CS", b"Capishark", b"Capybara + Shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b77ebb980d9f31511595a38ec4f2981dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

