module 0xaffc44ce25afb1ca72384dcc4b360a0810a800b7797d2b52f36e910f0a71145b::bwhale {
    struct BWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWHALE>(arg0, 6, b"BWHALE", b"BASED WHALE", b"Dive in, I am Whaling to support you. Underwater Crypto trader Blue base Whale launching now on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_01_19_10_2ac7a9e289.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

