module 0xadc7d177c06666c1e16697f8032f2f530a7af192b0752f564f172d204d80048a::bionic {
    struct BIONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIONIC>(arg0, 6, b"Bionic", b"Bionic Sui", b"Bionic Sui leaps from block to block, safeguarding the network and battling threats lurking in the shadows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bio_new_77b3ae3807.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

