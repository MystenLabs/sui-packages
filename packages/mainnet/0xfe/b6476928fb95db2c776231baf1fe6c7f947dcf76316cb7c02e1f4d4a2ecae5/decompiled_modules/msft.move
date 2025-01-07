module 0xfeb6476928fb95db2c776231baf1fe6c7f947dcf76316cb7c02e1f4d4a2ecae5::msft {
    struct MSFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFT>(arg0, 6, b"MSFT", b"Michaelsoft Binbows", b"The owner of the Michaelsoft Binbows 2001 shop shares a veil of anonymity reminiscent of the elusive Bitcoin creator, Satoshi Nakamoto. Despite the playful jest at Microsoft encapsulated in the shops name, and its subsequent embrace by internet meme culture, the individual behind this venture remains an enigmatic figure. Much like Satoshi, whose identity is shrouded in mystery despite the revolutionary cryptocurrency legacy, the proprietor of Michaelsoft Binbows stays concealed behind the screen of humor and satire, their identity unfurled only through the legacy of laughter and digital chatter they left behind. /WHO_CREATED_MICHAELSOFT_BINBOWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Michaelsoft_Binbows_178b478075.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

