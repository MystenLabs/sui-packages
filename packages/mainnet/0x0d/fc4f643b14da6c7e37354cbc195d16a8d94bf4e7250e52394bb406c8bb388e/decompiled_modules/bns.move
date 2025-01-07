module 0xdfc4f643b14da6c7e37354cbc195d16a8d94bf4e7250e52394bb406c8bb388e::bns {
    struct BNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNS>(arg0, 9, b"BNS", b"Banasui", b"Banana on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6bc50700d09c08b5813f8b759a3e2ef2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

