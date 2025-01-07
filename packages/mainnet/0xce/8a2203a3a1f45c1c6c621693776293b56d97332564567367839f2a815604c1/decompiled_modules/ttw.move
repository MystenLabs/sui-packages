module 0xce8a2203a3a1f45c1c6c621693776293b56d97332564567367839f2a815604c1::ttw {
    struct TTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTW>(arg0, 6, b"TTW", b"Tusk The Walrus", b"$TUSK Walrus Cult of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tusk_53a34f689a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

