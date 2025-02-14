module 0x7233f2e221ef736e8024437d2f665f96999e41e9751a3373714b477ecafe8871::vts {
    struct VTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTS>(arg0, 9, b"VTS", b"Volunteer Tech Support", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNtMFoK9gAtsKa28P7pCpUxRiDScvGzM22Mm5myb51S5u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VTS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

