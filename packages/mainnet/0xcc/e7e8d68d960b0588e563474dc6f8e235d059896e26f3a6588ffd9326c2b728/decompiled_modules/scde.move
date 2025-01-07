module 0xcce7e8d68d960b0588e563474dc6f8e235d059896e26f3a6588ffd9326c2b728::scde {
    struct SCDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCDE>(arg0, 6, b"SCDE", b"Suicide Prevention", b"Awareness of suicide from crypto losses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_25373feae3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

