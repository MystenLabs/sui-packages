module 0x443bcabe3dbe5f28dd15089ed33e0682cc86da88dbcdfb4267dc28a5f15bc76f::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"The Book of Sui", b"The Book of Sui Chain This sacred text holds the secrets of moonshots, pump prophecies, and the ancient art of buying the dip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/el_F_26_YT_400x400_efe9d10dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

