module 0xd9ad243484736220eb57aa3342dffc0736ba1023aea0a8109b7d1160e864ee9a::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 6, b"SUINU", b"Sui inu", x"53756920696e75206669727374207374616b696e672070726f6a656374206f6e207375690a0a4561726e206d6f6e65792077697468207374616b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026498_9f2f2f9c4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

