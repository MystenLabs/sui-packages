module 0x3be83a5ca1a30c58555aa3bfcb394456f9f9d88dce555d4dac4f5512451b42ea::kri {
    struct KRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRI>(arg0, 9, b"KRI", b"KriKri", x"4b7269204b7269204b7269204b7269204b726920f09fa697", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29b9eca3a9c5eb5dd48caea7b6bb4535blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

