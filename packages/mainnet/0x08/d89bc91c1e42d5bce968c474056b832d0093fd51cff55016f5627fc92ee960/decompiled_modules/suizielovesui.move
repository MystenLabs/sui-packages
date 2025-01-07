module 0x8d89bc91c1e42d5bce968c474056b832d0093fd51cff55016f5627fc92ee960::suizielovesui {
    struct SUIZIELOVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZIELOVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZIELOVESUI>(arg0, 6, b"SuiZieloveSui", b"SuiZie", b"SuiZieeee For American ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56_30044a1a6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZIELOVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZIELOVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

