module 0xf73c5a71220f5d29c8b60083f5dba564ec627011b539781268eb364484442156::hamsi {
    struct HAMSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSI>(arg0, 6, b"Hamsi", x"48616d7369202d2054c3bc726b697965276e696e20656e2062c3bc79c3bc6b20537569206d656d65636f696e2769206f6c6d6120796f6c756e6461", x"546f706c756c756b206f64616b6cc4b12076652065737072696c692079616b6c61c59fc4b16dc4b16dc4b17a6c612c206b726970746f2064c3bc6e796173c4b16e612072656e6b206b617461726b656e2c2079656e696c696bc3a7692074656b6e6f6c6f6a696c65726c6520646520796174c4b172c4b16d63c4b16c6172612067c3bcc3a76cc3bc2062697220616c74796170c4b1207361c49f6cc4b1796f72757a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiainrga5jmfkgu4ij3hqduvdk2mvio3h3gmjemrugihpsyvuasq6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

