module 0x6d6be5b5a903c9ed2a18695b96515ec46d333cc46964cb50f3e66b721126baa5::genie {
    struct GENIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIE>(arg0, 6, b"Genie", b"Sui Genie", b"Rub the lamp and make a wish with $GENIE on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Genie_577b5c4510.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

