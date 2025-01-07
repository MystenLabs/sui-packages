module 0xac71f05138c0304bb702627c4690db2233b4c594fd9e87d937fb52df1f3f7806::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIUUU CR7", x"496e737069726564206279207468652069636f6e696320437269737469616e6f20526f6e616c646f2063656c6562726174696f6e2c2054686520534955555520546f6b656e20697320612066756e20616e6420636f6d6d756e6974792d64726976656e206d656d6520636f696e206f6e207468652053554920626c6f636b636861696e2e204a6f696e207468652053495555552041726d7920616e642062652070617274206f6620612067726f77696e6720636f6d6d756e69747920746861742063656c6562726174657320746865206a6f79206f6620666f6f7462616c6c20616e642074686520746872696c6c206f662063727970746f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siuuuu_26f52cdc5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

