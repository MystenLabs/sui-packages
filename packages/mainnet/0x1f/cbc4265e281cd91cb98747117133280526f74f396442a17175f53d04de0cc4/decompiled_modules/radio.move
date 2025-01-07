module 0x1fcbc4265e281cd91cb98747117133280526f74f396442a17175f53d04de0cc4::radio {
    struct RADIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADIO>(arg0, 6, b"RADIO", b"SUI RADIOS", b"The first Radio NFT - Meme token on SUI Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_547870731b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RADIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

