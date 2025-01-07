module 0x377b334b744d897c9babda262d628de7f6e483d2b710a7ebe97a9b22b89dd50::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"PUMA", b"Hi, I'm PUMA on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/qM6XjtZ/tg-image-3149342154.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

