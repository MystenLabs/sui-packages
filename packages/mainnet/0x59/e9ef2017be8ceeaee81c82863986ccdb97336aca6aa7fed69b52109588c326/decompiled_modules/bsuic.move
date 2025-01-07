module 0x59e9ef2017be8ceeaee81c82863986ccdb97336aca6aa7fed69b52109588c326::bsuic {
    struct BSUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIC>(arg0, 6, b"BSUIC", b"Black SUI Cat", b"Look at my eyes, i am full of you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_123650291_dbbda8684e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

