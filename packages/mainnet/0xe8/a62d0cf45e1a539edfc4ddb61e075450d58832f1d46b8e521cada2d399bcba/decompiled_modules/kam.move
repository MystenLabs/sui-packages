module 0xe8a62d0cf45e1a539edfc4ddb61e075450d58832f1d46b8e521cada2d399bcba::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 9, b"KAM", b"King Arthur ", b"King Arthur is a legendary figure in British folklore, famously known as the ruler of Camelot and leader of the Knights of the Round Table. His story is a mix of myth, legend, and a little possible historical basis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cb5313b6d440dca8657426e8c7c8a788blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

