module 0xea8bcf272d27293cc23f7d34554fd0f5800c75a0b0d1664f8fe1f561cd6df3c2::stgykh {
    struct STGYKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STGYKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STGYKH>(arg0, 9, b"STGYKH", b"sfdghk", b"gdhl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/24bc5f45ad07829cfebb3c3728b2fec6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STGYKH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STGYKH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

