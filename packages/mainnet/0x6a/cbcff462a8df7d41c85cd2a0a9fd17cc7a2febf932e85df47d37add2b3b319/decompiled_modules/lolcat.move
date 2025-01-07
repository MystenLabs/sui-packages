module 0x6acbcff462a8df7d41c85cd2a0a9fd17cc7a2febf932e85df47d37add2b3b319::lolcat {
    struct LOLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLCAT>(arg0, 6, b"LOLCAT", b"$LOLCAT", x"4c6f6c63617420697320666972737420706f73746564206d656d6520636174206f6e20626974636f696e74616c6b2066726f6d2032362020446563656d62657220323031302e200a0a5573657220536861646f774f664861726272696e6765722073686172656420746869732063617420616e642064657363726962656420697420617320666f6c6c6f77733a2022686f7720636f756c6420616e79626f647920726566757365207468697320736f667420666c75666679206c6974746c65206c6f6c636174203f22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_03_20_20_326f23c6af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

