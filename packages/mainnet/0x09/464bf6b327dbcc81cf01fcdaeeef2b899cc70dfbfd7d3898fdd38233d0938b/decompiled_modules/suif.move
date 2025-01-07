module 0x9464bf6b327dbcc81cf01fcdaeeef2b899cc70dfbfd7d3898fdd38233d0938b::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"SUIFLOKI", b"FLOKI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5987939251582518022_x_2671de2210.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

