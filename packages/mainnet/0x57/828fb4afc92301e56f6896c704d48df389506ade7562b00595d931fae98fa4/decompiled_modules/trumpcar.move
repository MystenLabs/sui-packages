module 0x57828fb4afc92301e56f6896c704d48df389506ade7562b00595d931fae98fa4::trumpcar {
    struct TRUMPCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCAR>(arg0, 9, b"TRUMPCAR", b"Carcoin", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bcc53222d9331890db50da8a3c738305blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPCAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

