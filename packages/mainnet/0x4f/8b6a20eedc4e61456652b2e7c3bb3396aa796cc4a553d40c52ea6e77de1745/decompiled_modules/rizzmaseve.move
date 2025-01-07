module 0x4f8b6a20eedc4e61456652b2e7c3bb3396aa796cc4a553d40c52ea6e77de1745::rizzmaseve {
    struct RIZZMASEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMASEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZMASEVE>(arg0, 6, b"RizzmasEve", b"RizzmasEve on SUI", b"RizzmasEve  from the creators of Rizzmas! Big gains ahead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dtabq_QTO_400x400_ff8987c053.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMASEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMASEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

