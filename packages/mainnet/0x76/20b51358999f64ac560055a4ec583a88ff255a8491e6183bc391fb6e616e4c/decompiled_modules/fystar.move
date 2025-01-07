module 0x7620b51358999f64ac560055a4ec583a88ff255a8491e6183bc391fb6e616e4c::fystar {
    struct FYSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYSTAR>(arg0, 9, b"FySTAR", b"star friendy", b"This star ever smiles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5d52e0f9fcb5b3d448f1c841e4bee894blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FYSTAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYSTAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

