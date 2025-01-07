module 0xd4274090b6c6c4a04f68a5f38b9125bd500e17a362ba479a7a914aa28ded4fa7::waz {
    struct WAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAZ>(arg0, 6, b"WAZ", b"Mike Sui", x"4d696b65206272696e6773204d656d657320616e642046756e20746f20535549207769746820686973206f776e20746563686e69717565206d6f64756c6573206578636c75736976656c7920666f7220484f4c44455253210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DJ_0lo70r_400x400_37a48019a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

