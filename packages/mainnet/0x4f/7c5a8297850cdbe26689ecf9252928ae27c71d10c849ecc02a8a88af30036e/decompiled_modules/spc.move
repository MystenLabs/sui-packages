module 0x4f7c5a8297850cdbe26689ecf9252928ae27c71d10c849ecc02a8a88af30036e::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"Suspect Cat", b"Keep your wallet safe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd2b12f6e1c080922d28927d96d9d0e6_fc2360463c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

