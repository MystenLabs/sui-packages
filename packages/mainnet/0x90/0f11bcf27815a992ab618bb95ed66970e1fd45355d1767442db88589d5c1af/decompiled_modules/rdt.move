module 0x900f11bcf27815a992ab618bb95ed66970e1fd45355d1767442db88589d5c1af::rdt {
    struct RDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDT>(arg0, 9, b"rdt", b"reddit to te moon", b"Reddit comunity on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMaw3PLczI3sNbPHt3LlYHEh1KpHxMpFZf9A&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RDT>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

