module 0x5c79fe6de1f9a558c0c25d0c59a5a8dec59f96fe88709abb73c435903b95d13b::genaro {
    struct GENARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENARO>(arg0, 9, b"GENARO", b"TNT Meme", b"Here Your Future's MemeCoin Received On Top Of The Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/946926f4-6696-48cc-af60-5eca747d655b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

