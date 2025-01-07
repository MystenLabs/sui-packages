module 0x7f1cee5b1a12b1c92e6f7b55733abbb7900783c8384dffd2ed7c17413008198c::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 6, b"PSD", b"Posuidon", b"Mythology has the sea god Poseidon. Sui has the uptrend god Posuidon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/god_of_greek_mythology_neptune_poseidon_eda5c7ebd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

