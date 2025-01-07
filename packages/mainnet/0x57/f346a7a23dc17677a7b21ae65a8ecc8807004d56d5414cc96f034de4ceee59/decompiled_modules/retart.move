module 0x57f346a7a23dc17677a7b21ae65a8ecc8807004d56d5414cc96f034de4ceee59::retart {
    struct RETART has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETART>(arg0, 6, b"RETART", b"retartet baby", b"aaaamm reetartetttttttt.. leetz maeke historyy toogehterr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/989_a441f097de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETART>>(v1);
    }

    // decompiled from Move bytecode v6
}

