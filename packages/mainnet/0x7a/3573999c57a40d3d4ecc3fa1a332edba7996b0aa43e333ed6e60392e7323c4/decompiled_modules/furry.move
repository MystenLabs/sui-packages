module 0x7a3573999c57a40d3d4ecc3fa1a332edba7996b0aa43e333ed6e60392e7323c4::furry {
    struct FURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRY>(arg0, 6, b"FURRY", b"FURRY BY MATT FURIE", x"4d6565742046555252592c2074686520756c74696d617465206c6f7661626c65206461642077686f732066757272696572207468616e20796f7572206772616e646d6173206f6c642063617270657420616e642066756e6e696572207468616e2061206a6f6b6520626f6f6b2066726f6d2074686520646f6c6c61722073746f72652e20467572727920697320666561747572656420696e204d617474204675726965277320274d696e64766973636f73697479270a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3654_12e7d3a5fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

