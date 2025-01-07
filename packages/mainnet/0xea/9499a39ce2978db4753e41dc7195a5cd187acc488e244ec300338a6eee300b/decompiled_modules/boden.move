module 0xea9499a39ce2978db4753e41dc7195a5cd187acc488e244ec300338a6eee300b::boden {
    struct BODEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BODEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BODEN>(arg0, 6, b"BODEN", b"Jeo Boden", b"The $BODEN token, also known as the Joe Boden token, is a memecoin that humorously references Joe Biden. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_28_00_59_31_72b637335d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BODEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BODEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

