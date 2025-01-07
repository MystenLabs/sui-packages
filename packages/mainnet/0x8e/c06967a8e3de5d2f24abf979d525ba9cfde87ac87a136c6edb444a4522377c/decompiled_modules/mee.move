module 0x8ec06967a8e3de5d2f24abf979d525ba9cfde87ac87a136c6edb444a4522377c::mee {
    struct MEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEE>(arg0, 9, b"MEE", b"Me Everyday", b"Me Everyday meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreig3ldfbypj66zgdsjs3vely4wlr4btg7lo2izno6roia6hgotbhzy.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

