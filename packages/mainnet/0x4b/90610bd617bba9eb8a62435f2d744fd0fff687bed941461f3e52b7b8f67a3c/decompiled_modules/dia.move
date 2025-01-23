module 0x4b90610bd617bba9eb8a62435f2d744fd0fff687bed941461f3e52b7b8f67a3c::dia {
    struct DIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIA>(arg0, 9, b"DIA", b"DIAMOND", b"DIAMOND IS ________", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e8d02f27da1ae13f6286b2c930701354blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

