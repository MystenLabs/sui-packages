module 0x12ebd3dffd5648a62146381710bf9ed6e770de9080bd2ffbd087b0a51d3585ad::bpc {
    struct BPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPC>(arg0, 6, b"BPC", b"BluePunisherCoin", b"AI depiction of the legendary Blue Punisher.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a031fc2e_c81b_474c_b1d4_ef2a98b9c972_d5c12c8655.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

