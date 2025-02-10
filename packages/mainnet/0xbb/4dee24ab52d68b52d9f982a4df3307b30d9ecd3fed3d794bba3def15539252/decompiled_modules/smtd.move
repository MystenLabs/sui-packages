module 0xbb4dee24ab52d68b52d9f982a4df3307b30d9ecd3fed3d794bba3def15539252::smtd {
    struct SMTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMTD>(arg0, 9, b"SMTD", b"SmartDoge", b"SmartDoge was born when a mischievous internet meme doge stumbled upon a secret alien technology, granting it unparalleled intelligence. This genius canine now spends its days solving complex equations and plotting world domination, all while maintaining its love for chasing cats and barking at the moon. Its rise to fame has inspired a new breed of crypto tokens, each representing a unique doge's achievement in the sci-fi universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMTD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMTD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

