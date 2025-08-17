module 0xba60988b520e0bcce37bd54a39ca1ec57e38bebf69a32f515ec07a846f41d421::blasta {
    struct BLASTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTA>(arg0, 9, b"BLASTA", b"YES BLAST IS ASS", b"blast is ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASTA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTA>>(v2, @0x341e34c6e78efa411d91c73809eb5bee7669f5c9da0421de6dc21857f8b68f57);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

