module 0xe30427bec492a377e12bf6736b3b57afe43996699bcd6fc34cf9286eb68196ee::upcat {
    struct UPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPCAT>(arg0, 6, b"UPCAT", b"The Uponly Cat", b"UPCAT - Memecoin the best cat that will jump high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019209_523e62dd88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

