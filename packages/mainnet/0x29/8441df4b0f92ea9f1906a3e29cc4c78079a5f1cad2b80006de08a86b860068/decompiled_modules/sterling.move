module 0x298441df4b0f92ea9f1906a3e29cc4c78079a5f1cad2b80006de08a86b860068::sterling {
    struct STERLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: STERLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STERLING>(arg0, 9, b"STERLING", b"Silver Seal", b"Silver items are real value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/106f13eaf0c023a9963aeab4f474a577blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STERLING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STERLING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

