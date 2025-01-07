module 0x261d50017babd9b3fb2fc6dec6a4ff7be1d439f124170fbcd878dbb036ee9e3::squija {
    struct SQUIJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIJA>(arg0, 6, b"SQUIJA", b"Squirrel Ninja", b"SQUIJA- a squirrel in Sui network and who has ninja powers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009168_109a47880f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

