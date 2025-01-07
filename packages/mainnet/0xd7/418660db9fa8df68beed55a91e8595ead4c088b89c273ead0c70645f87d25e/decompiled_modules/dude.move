module 0xd7418660db9fa8df68beed55a91e8595ead4c088b89c273ead0c70645f87d25e::dude {
    struct DUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDE>(arg0, 6, b"Dude", b"Sui-dude", b"Sui-dude up in a world of complex financial systems, but instead of following the cold, hard numbers, he wanted to bring joy and connection to the Sui  Network. Hes the token that says, Its okay to have fun while investing! Whether you are a newbie or a seasoned pro,Sui-dude here to guide you with his easygoing attitude and a wink of reassurance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2021_11_06_at_9_36_12_PM_56920ee150.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

