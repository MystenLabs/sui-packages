module 0xae4c215641fb8325990e0aab84ecf1b9d4e9c072b7d017933c29b734d6b97896::pacato {
    struct PACATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACATO>(arg0, 6, b"Pacato", b"PACATO", b"https://x.com/brian_armstrong/status/1844040530621272279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_14_34_35_82028450bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

