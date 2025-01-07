module 0xd7ebdc6464745ea0ee954fa5907c59f24b0f3eae0723538b072e665626a17ba1::urchn {
    struct URCHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: URCHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URCHN>(arg0, 6, b"URCHN", b"Urchin Network", b"Urchin Network is a decentralized project built on the SUI blockchain, designed to empower communities through transparent governance, scalability, and innovative DeFi solutions. The project aims to create a robust ecosystem where users can participate in secure, fast, and low-cost transactions, while also contributing to governance through its native token. By leveraging SUI's cutting-edge technology, Urchin Network fosters a decentralized economy that benefits both individual users and larger organizations, with a focus on sustainability, inclusivity, and long-term growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Urchin_Network_9cc4fa0eb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URCHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URCHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

