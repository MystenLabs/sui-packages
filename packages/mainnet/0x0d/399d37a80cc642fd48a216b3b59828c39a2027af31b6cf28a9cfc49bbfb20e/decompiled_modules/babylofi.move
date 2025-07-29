module 0xd399d37a80cc642fd48a216b3b59828c39a2027af31b6cf28a9cfc49bbfb20e::babylofi {
    struct BABYLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLOFI>(arg0, 6, b"BabyLofi", b"Baby Lofi", b"My name is BABY LOFI Lofi is my dad, we was frozen for centuries, but we've awakened and i'm ready to build a brighter future. Join me and my YETI FAM. Together, well shape the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihsnmwmum6geecpm7l3q2cnxfgawjtliekjcg3rrpvb3l5dvnyqgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYLOFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

