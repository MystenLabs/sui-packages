module 0x221e1f87114570a376fd1a33368b128ef68bf8f1d743cd05bb11c5eee01a3e34::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"Fuck Around Find Out", b"Everyone has done it at some point in their Web3 Journey but now being celebrated as a token. Come $FAFO Fuck Around-Find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_0f23eebdd1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

