module 0xf6ce85cd294e307cc66e824a0b1fb8423e43c01ee793e0bbd99cd0d0d39bfd0e::flxcat {
    struct FLXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLXCAT>(arg0, 6, b"FLXCAT", b"Felix The Cat on SUI", b"Felix the Cat $FLXCAT stands as the premier feline-themed Cryptocurrency on the Solana Blockchain, boasting a rich, century-long global legacy in meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Nk9_O_Iki_400x400_b27da29aa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

