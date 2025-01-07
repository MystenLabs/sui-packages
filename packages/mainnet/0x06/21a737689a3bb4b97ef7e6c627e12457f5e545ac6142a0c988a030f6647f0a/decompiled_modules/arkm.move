module 0x621a737689a3bb4b97ef7e6c627e12457f5e545ac6142a0c988a030f6647f0a::arkm {
    struct ARKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARKM>(arg0, 6, b"ARKM", b"ARKHAM SUI COMMUNITY", x"5355492041524b48414d204a75737420666f7220636f6d6d756e6974792064726976656e0a5468657265206973206e6f2077656273697465200a5468657265206973206e6f2074670a5468657265206973206e6f2078", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8771_4095a63b86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

