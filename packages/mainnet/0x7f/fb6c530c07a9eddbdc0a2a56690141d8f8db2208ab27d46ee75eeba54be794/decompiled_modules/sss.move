module 0x7ffb6c530c07a9eddbdc0a2a56690141d8f8db2208ab27d46ee75eeba54be794::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 9, b"SSS", b"Sui and sei", b"x.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/1bacf0b28cb6ae66a70699f73f083a81blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

