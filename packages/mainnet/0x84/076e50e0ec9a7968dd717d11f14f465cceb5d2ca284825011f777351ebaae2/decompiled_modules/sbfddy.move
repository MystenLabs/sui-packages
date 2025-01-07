module 0x84076e50e0ec9a7968dd717d11f14f465cceb5d2ca284825011f777351ebaae2::sbfddy {
    struct SBFDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBFDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBFDDY>(arg0, 6, b"SBFDDY", b"SBFDIDDY", x"53424620686173206e6f2061636365737320746f206d656d6573206275742077617320676976656e2061636365737320746f204469646479205365616e204a6f686e736f6e2e0a446964647920676f6e6e61204176656e6765207468652043525950544f20436f6d6d756e6974792e204c4f4c0a4c4647", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/In_Shot_20240925_121849394_430c997263.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBFDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBFDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

