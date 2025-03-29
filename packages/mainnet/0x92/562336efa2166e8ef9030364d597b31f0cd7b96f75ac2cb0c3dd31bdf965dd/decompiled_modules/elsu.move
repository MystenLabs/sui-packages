module 0x92562336efa2166e8ef9030364d597b31f0cd7b96f75ac2cb0c3dd31bdf965dd::elsu {
    struct ELSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELSU>(arg0, 9, b"ElSu", b"elmonsu", b"ElMonSu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bd8748597ea74d3ee16301fb11f21348blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

