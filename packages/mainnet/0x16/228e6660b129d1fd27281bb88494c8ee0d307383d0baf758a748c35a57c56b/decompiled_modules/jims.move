module 0x16228e6660b129d1fd27281bb88494c8ee0d307383d0baf758a748c35a57c56b::jims {
    struct JIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMS>(arg0, 6, b"JIMS", b"Jims The Plankton", b"JIMS is the forgotten King of the plankton nation, for years enjoying life as an ordinary plankton, now a box is opened to the fact that he is the real king, let's help JIMS fulfill his destiny, and Atlantis is a gift for us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_04_27_36_2dee9c196e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

