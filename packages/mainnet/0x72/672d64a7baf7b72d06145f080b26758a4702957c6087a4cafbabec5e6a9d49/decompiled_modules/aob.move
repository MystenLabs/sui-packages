module 0x72672d64a7baf7b72d06145f080b26758a4702957c6087a4cafbabec5e6a9d49::aob {
    struct AOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOB>(arg0, 9, b"AOB", b"ayoouub", b"THIS IS THE FIRST EVER MEME COIN ON MEMEDEXX!!!!!!!!!!!!!!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.recrd.com/discover?post_id=8d41e430-f948-11ec-8ebd-a33c88c5f866&ref=ed203220-3627-11f0-8ed8-bfb2130e5108")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AOB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOB>>(v2, @0xcd77bc1e00ce9b6eb15bbd89d7e4521330c5fa8a170da7d12081a1d0b003a95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

