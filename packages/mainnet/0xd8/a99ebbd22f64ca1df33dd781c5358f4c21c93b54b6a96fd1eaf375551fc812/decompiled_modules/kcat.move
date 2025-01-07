module 0xd8a99ebbd22f64ca1df33dd781c5358f4c21c93b54b6a96fd1eaf375551fc812::kcat {
    struct KCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCAT>(arg0, 6, b"KCAT", b"KING CAT", b"Not just a Meme King Cat is also the king of all types of Memes with a rich and potential ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OH_Drtnu_R_400x400_238d58e5dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

