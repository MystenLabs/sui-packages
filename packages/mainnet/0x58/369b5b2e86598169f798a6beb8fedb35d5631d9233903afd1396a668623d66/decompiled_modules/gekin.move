module 0x58369b5b2e86598169f798a6beb8fedb35d5631d9233903afd1396a668623d66::gekin {
    struct GEKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEKIN>(arg0, 6, b"GEKIN", b"GEK In The Game", b"A 501c3 youth spots organization fundraising on the SUI network. GEK is our mascot. He's a chubby little lizard that loves sports! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gekrunning_138bad38a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

