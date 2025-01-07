module 0x587a3936ec9825b8f25beb89dc9d2e0c4c30ad9d143551def792214e5310b85a::ottokar {
    struct OTTOKAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTOKAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTOKAR>(arg0, 6, b"OTTOKAR", b"Ottokar II King of Bohemia", b"Ottokar II, King of Bohemia (1233-1278); member of the Premyslid dynasty and the Original Boys Club. Reigned as King of Bohemia from 1253. He also held the titles of Margrave of Moravia from 1247, Duke of Austria from 1251, Duke of Styria from 1260, and Duke of Carinthia and landgrave of Carniola from 1269. Known as \"the Iron and Golden King\" he also got hit in the nuts really hard this one time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTOKAR_479a63cda7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTOKAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTOKAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

