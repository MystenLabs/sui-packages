module 0xa66927d77aed9e22e659f8ecf5c433644bcd62e3a20a4096de544c41afd4370a::dpb {
    struct DPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPB>(arg0, 9, b"DPB", b"Deep Blue", b"Chess Computer or Deep in the Ocean?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e0633664ebbaabf77d295b46bdc6c26dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

