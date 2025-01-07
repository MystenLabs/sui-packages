module 0x2d0c52929f124cfe001858420c7a489bda9f28067ef769beecd05c0a6904be8e::vcat {
    struct VCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCAT>(arg0, 6, b"VCAT", b"Catventure", x"436174202b20416476656e74757265203d2043617476656e74757265200a54686520756c74696d6174652067616d696e672d746f2d6561726e20657870657269656e636520697320686572652120506c61792c206561726e2c20616e6420686176652066756e207769746820746865206d6f737420616476656e7475726f7573206d656d6520636f696e20657665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008148_ead05a43f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

