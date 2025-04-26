module 0xe06939f4dca90417402c902cd73337cb731a6e12ebc0aa3cd1e0c11a1b1a9254::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 9, b"DGS", b"degens", b"token for really degens!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ce96ecfbbe61b44157bee3616a5c105cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

