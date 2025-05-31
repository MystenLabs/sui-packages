module 0xe1b82a28163ab6bc32c658b571b9b238b5cb2b41cfed0c6b9499d5575f19b779::munki {
    struct MUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKI>(arg0, 6, b"MUNKI", b"MUNKIDORI", b"Munkidori didn't ask for permission. He just appeared. Now he's counting Sui, riding trikes, skating through timelines, and making memes great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiagcl2g7nckrxylrfmzow4qy2xczgmrhfwqb6pwk7vgbt7ncsazai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUNKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

