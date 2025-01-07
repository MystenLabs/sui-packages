module 0xaef5b43f8f8668fa010ac76a5d30d780bbf55ae58786b44ed91f389b6f0bf31d::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUI CAT", x"5355492043415420697320746865206e65787420626967206d656d6520636f696e206f6e2074686520537569204e6574776f726b0a53757267696e67207072696365732c2067726f77696e67206c69717569646974792c20616e64206875676520706172746e657273686970", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1049_bce799d23d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

