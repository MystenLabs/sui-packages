module 0x6814345688b94a1d5247315015cbfb5217de3918d58c6af9530c23c5b91f3679::udsui {
    struct UDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDSUI>(arg0, 9, b"UDSui", b"Urine Drop", b"Urine increases Water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c9dca5d73ec15d92e798d76fba2d05bcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

