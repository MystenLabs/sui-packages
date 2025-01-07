module 0xf36b8f06abceba045162a5e7f0f78ccf486488117c7ec82cab6bd87d37d060eb::sui613 {
    struct SUI613 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI613, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI613>(arg0, 6, b"Sui613", b"Sui blackfriday", b"celebrate black friday the 13th on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Rkvh_H4bk_AAR_2_L_2284f9f006.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI613>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI613>>(v1);
    }

    // decompiled from Move bytecode v6
}

