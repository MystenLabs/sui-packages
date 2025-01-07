module 0x68f1ef6bfa8984e579e06e30efb690e1fae3574da95b3b955f8d16ce28e79580::fwosty {
    struct FWOSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOSTY>(arg0, 6, b"FWOSTY", b"FWosty the SWoman", b"Everyone knows that behind every good Snowman is a good Swoman. I am Frosty's wife and I am the backbone to the lore of Frosty the Snowman. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054639_db60205ee1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

