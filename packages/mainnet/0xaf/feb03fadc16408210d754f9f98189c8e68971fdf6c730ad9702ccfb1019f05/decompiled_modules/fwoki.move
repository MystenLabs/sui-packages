module 0xaffeb03fadc16408210d754f9f98189c8e68971fdf6c730ad9702ccfb1019f05::fwoki {
    struct FWOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOKI>(arg0, 6, b"FWOKI", b"Fwoki", b"Meet FWOKI: the Viking doge of the crypto seas! With a helmet of gold and a tail of pure meme magic, FWOKI is here to pillage your doubts and raid your wallets with laughter. It's like if Ragnar Lothbrok and Doge had a digital babyfearless, funny, and ready to conquer the SUI blockchain. Get on board or risk walking the plank of boredom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fwoki_logo_fb10faa12d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

