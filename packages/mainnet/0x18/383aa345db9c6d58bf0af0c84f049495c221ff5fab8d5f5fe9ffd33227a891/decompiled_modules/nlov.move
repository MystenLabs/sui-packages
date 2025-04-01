module 0x18383aa345db9c6d58bf0af0c84f049495c221ff5fab8d5f5fe9ffd33227a891::nlov {
    struct NLOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLOV>(arg0, 9, b"NLOV", b"Nature lover", b"Nature is the real beauty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ae9cffce083a3b00dd842d152bc8fbceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLOV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLOV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

