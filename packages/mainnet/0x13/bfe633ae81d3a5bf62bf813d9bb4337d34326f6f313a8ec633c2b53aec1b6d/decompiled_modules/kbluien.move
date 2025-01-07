module 0x13bfe633ae81d3a5bf62bf813d9bb4337d34326f6f313a8ec633c2b53aec1b6d::kbluien {
    struct KBLUIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBLUIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBLUIEN>(arg0, 6, b"KBLUIEN", b"I Like To Move It", b"King Bluien likes to move it, move it. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_18_192018_d115a8ed5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBLUIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBLUIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

