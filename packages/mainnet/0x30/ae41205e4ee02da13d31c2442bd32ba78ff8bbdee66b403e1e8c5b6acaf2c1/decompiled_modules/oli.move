module 0x30ae41205e4ee02da13d31c2442bd32ba78ff8bbdee66b403e1e8c5b6acaf2c1::oli {
    struct OLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLI>(arg0, 9, b"OLI", b"olinap", b"Napoli !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/56df842b7a01c149a1a282f2ad0b1c03blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

