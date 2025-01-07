module 0x2f1b0ed563b502de7ffb61cea4634f0c5758161ed8e614dbcd0df7ac11bd1c0e::sisw {
    struct SISW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISW>(arg0, 6, b"SISW", b"Suilien In Sui World", b"Your favorite blue alien from Suiworld! Spreading memes, chaos, and intergalactic vibes while pumping Sui straight to the moon. Hop on the mothership and lets get weird. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_f45dd33425.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISW>>(v1);
    }

    // decompiled from Move bytecode v6
}

