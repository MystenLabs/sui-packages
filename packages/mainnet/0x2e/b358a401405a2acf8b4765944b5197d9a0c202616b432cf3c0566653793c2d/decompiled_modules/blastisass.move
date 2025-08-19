module 0x2eb358a401405a2acf8b4765944b5197d9a0c202616b432cf3c0566653793c2d::blastisass {
    struct BLASTISASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTISASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTISASS>(arg0, 9, b"BLASTISASS", b"_A_", b"BLAST IS ASS smells like it too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASTISASS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTISASS>>(v2, @0x341e34c6e78efa411d91c73809eb5bee7669f5c9da0421de6dc21857f8b68f57);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTISASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

