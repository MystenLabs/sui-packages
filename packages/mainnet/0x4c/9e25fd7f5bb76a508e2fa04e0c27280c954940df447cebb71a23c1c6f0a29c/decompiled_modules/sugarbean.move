module 0x4c9e25fd7f5bb76a508e2fa04e0c27280c954940df447cebb71a23c1c6f0a29c::sugarbean {
    struct SUGARBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGARBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGARBEAN>(arg0, 6, b"SugarBean", b"Sugar Bean", b"Let's jump together, crazy jelly bean boy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012743_bcbc7b4221.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGARBEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGARBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

