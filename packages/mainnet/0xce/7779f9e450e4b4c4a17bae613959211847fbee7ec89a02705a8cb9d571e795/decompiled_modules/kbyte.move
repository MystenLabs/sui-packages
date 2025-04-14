module 0xce7779f9e450e4b4c4a17bae613959211847fbee7ec89a02705a8cb9d571e795::kbyte {
    struct KBYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBYTE>(arg0, 9, b"KBYTE", b"KarmaByte", x"41206665656c2d676f6f6420746f6b656e207468617420726577617264732061637473206f66206b696e646e6573732e20446f6e6174652c20766f6c756e746565722c206f722068656c7020736f6d656f6e6520e28094206561726e204b425954452e2046756c6c79207472616e73706172656e7420626c6f636b636861696e207265636f726473206f6620696d7061637420616e6420612076696272616e742065636f73797374656d206f6620646f2d676f6f646572732e20446f20676f6f642e2047657420746f6b656e732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7bd6d43703bbd02e86228b4eb40365e3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KBYTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBYTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

