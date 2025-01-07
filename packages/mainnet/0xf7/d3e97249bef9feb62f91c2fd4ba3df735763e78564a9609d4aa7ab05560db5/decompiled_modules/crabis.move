module 0xf7d3e97249bef9feb62f91c2fd4ba3df735763e78564a9609d4aa7ab05560db5::crabis {
    struct CRABIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABIS>(arg0, 6, b"CRABIS", b"CRABIS!", x"435241626973207761736e2774206a75737420626f726e20746f207377696d2068652077617320626f726e20746f0a484f444c212054686973206a61636b65642d757020637261622068617320636c6177656420686973207761792066726f6d0a7468652064656570207365617320746f2074686520746f70206f66207468652063727970746f2067616d652c20666c6578696e670a626f746820686973206d7573636c657320616e6420686973206d656d6520636f696e732e204b6e6f776e20666f72206869730a7369676e6174757265206d6f76652c20546865206372616220466c69702c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_6fd5c263c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

