module 0x3db80ad2b721af1b0b7114ae32d0c7f416139d11072d11934155144cb0866fc6::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZMAS>(arg0, 9, b"RIZZMAS", b"Rizzmas on SUI", b"The unofficial X account for RIZZMAS on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/146fc49ecf025711183755099968bb99blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

