module 0xc1b6daa3cc8b7f3e6a9ff31f5a9f65a8496830c456aae391365d968709ca33e::nalien {
    struct NALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALIEN>(arg0, 6, b"NALIEN", b"Narco Alien", x"4920616d20616e20616c69656e2077686f206c6f7665732064727567732e20427574206f6e6c7920676f6f64206f6e65732e204d79207370616365736869702063726173686564206f6e207468697320706c616e657420616e642049206e65656420746f20676574206261636b20746f206d7920776f726c642e20436f6d652077697468206d6520616e642077652077696c6c20666c79206d7563682066757274686572207468616e206d6f6f6e2e200a42656c69657665206d652c207765206861766520676f6f64207368697420746f20736e6966662074686572652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_11_14_30_30_a17771acf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

