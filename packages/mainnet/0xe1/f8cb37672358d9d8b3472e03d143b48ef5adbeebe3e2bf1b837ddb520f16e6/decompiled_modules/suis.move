module 0xe1f8cb37672358d9d8b3472e03d143b48ef5adbeebe3e2bf1b837ddb520f16e6::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 9, b"Suis", b"7Eth", b"fb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a30801e6b9fd7a4a9d026628529ac978blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

