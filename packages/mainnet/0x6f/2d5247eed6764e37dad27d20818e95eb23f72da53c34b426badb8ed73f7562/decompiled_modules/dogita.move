module 0x6f2d5247eed6764e37dad27d20818e95eb23f72da53c34b426badb8ed73f7562::dogita {
    struct DOGITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGITA>(arg0, 6, b"DOGITA", b"Dogita", b"The First DOGE with a Female Doge! Dogita is the first-ever upgrade of the viral DOGE meme on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_9e55a4798d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

