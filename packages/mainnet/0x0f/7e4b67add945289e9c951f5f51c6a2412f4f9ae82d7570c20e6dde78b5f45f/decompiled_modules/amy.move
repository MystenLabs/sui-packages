module 0xf7e4b67add945289e9c951f5f51c6a2412f4f9ae82d7570c20e6dde78b5f45f::amy {
    struct AMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMY>(arg0, 6, b"Amy", b"amymidget", x"49276d20796f7572206c6974746c6520416d79202049276d203230797273206f6c642c20332731302e2e2e2049276d206c6f6f6b696e67206f757420666f7220736f6d656f6e652077686f204920636f756c6420626520636f6d666f727461626c652074656c6c696e67206d792073656372657473200a737570706f7274206d6520696e20746869732070726f6a656374206d6520616e64206d6179626520492063616e207370696c6c206d79206469727479206c6974746c65207365637265747320746f20796f75206869686920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ui_4f20a1ef7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

