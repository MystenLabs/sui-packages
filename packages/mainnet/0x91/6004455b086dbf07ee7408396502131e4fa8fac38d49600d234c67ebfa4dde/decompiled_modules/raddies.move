module 0x916004455b086dbf07ee7408396502131e4fa8fac38d49600d234c67ebfa4dde::raddies {
    struct RADDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADDIES>(arg0, 6, b"RADDIES", b"Raddies on SUI", x"31313131205261646469657320636f6d696e6720736f6f6e206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wo_U_Mp90_400x400_908d2d1013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RADDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

