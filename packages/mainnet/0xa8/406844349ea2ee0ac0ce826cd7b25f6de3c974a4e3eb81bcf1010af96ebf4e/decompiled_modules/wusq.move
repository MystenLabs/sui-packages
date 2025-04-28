module 0xa8406844349ea2ee0ac0ce826cd7b25f6de3c974a4e3eb81bcf1010af96ebf4e::wusq {
    struct WUSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSQ>(arg0, 9, b"WUSQ", b"WUSQ2", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5370682b14bbef7d260adf02728b591eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUSQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

