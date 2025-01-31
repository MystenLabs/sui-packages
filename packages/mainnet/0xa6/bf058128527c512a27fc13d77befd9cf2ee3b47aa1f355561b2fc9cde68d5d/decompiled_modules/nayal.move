module 0xa6bf058128527c512a27fc13d77befd9cf2ee3b47aa1f355561b2fc9cde68d5d::nayal {
    struct NAYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAYAL>(arg0, 6, b"Nayal", b"Naylai", b" AI is here to revolutionize the way you create, design, and innovate. With cutting-edge tools and intuitive interfaces, our platform empowers you to bring your ideas to life faster, better, and smarter. Whether youre crafting compelling copy, generating stunning visuals, or writing clean, functional code, NYLA AI has you covered.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017277_fed3ab0dc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

