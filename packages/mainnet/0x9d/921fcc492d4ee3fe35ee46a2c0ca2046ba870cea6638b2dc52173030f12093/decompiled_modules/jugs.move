module 0x9d921fcc492d4ee3fe35ee46a2c0ca2046ba870cea6638b2dc52173030f12093::jugs {
    struct JUGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUGS>(arg0, 6, b"Jugs", b"JugsofSui", b"Hodl more Sui with bigger Jugs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jugs_a76a556913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

