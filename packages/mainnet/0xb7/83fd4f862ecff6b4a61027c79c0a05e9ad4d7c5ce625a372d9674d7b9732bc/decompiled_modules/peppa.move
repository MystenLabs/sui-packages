module 0xb783fd4f862ecff6b4a61027c79c0a05e9ad4d7c5ce625a372d9674d7b9732bc::peppa {
    struct PEPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPA>(arg0, 9, b"Peppa", b"Peppa pig", b"Peppa, an anthropomorphic female piglet, and her family, as well as her peers portrayed as other animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/f094e00bd3af9ef278be2ea6374209cfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

