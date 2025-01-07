module 0xed9646066dc7925371d3ac5a11acd75fb60ab0c4e28353b5a1d1c9c6439077ce::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUI CATCOIN", x"537569636174206d6164652066726f6d206d656f6f77770a0a68747470733a2f2f742e6d652f737569636174706f7274616c0a68747470733a2f2f7375696361742e66756e2f0a0a546865204f472043617420436f696e206f6e205375690a47657420696e206f6e207468652067726f756e6420666c6f6f722077697468205375692043617420616e642062652070617274206f6620746865204f472063617420636f696e207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3607_e91cb35f23.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

