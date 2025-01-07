module 0x80aca2ed5f4721e4e4d76eacb9f7946524130c6ae64b1d2d271459ac0af5c9e4::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"DORKLORD SuI", b"Prepare yourself, young Padawan, for the most epic memecoin in the $SUI galaxy: DORKLORD! May the Memes be with you!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_2526fe434d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

