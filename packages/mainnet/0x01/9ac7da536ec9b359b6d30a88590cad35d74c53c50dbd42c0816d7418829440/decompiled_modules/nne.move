module 0x19ac7da536ec9b359b6d30a88590cad35d74c53c50dbd42c0816d7418829440::nne {
    struct NNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNE>(arg0, 9, b"NNe", b"miyy80", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/692d024dc8e0a2c957b7b51a0eef2171blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

