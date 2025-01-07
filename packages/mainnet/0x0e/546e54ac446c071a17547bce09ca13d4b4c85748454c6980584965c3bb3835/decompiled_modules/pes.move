module 0xe546e54ac446c071a17547bce09ca13d4b4c85748454c6980584965c3bb3835::pes {
    struct PES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PES>(arg0, 6, b"PES", b"pepesui", b"Get your share and I promise you will become a millionaire but on the condition that you do not sell before we reach one million market cap and that will be in a few hours", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Vision_XL_logo_for_pepe_sui_meme_coin_blue_2_9a190c7812.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PES>>(v1);
    }

    // decompiled from Move bytecode v6
}

