module 0x66f459bd177c805e31e2eae9438db50f7b7863cde726f2e756a55a737fb3a31a::SSB {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SadSuiBirthday", b"SSB", b"A meme coin for those who've blown their accounts and are staring at their birthdays with empty wallets. Rally the community, share the pain, and maybe get a birthday tip or two!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreigq6e5rzr75nxqaruwhryqazl5stgafcknghk5qt3y6s43i7fkvmq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, @0xd6a8b52e083404049bde79d556925b3fa2b72340a6d1e018900ae8f13ba3af5b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

