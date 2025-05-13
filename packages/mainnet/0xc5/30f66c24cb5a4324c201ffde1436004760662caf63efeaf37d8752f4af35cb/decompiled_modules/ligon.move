module 0xc530f66c24cb5a4324c201ffde1436004760662caf63efeaf37d8752f4af35cb::ligon {
    struct LIGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGON>(arg0, 6, b"LIGON", b"Ligon", b"Meet the Litch Dragon ($LIGON), a fire monster that breathes underwater and air.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069535_d84d2ec8d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

