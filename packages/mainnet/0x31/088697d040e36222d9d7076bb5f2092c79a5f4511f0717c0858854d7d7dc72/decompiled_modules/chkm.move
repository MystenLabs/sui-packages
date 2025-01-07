module 0x31088697d040e36222d9d7076bb5f2092c79a5f4511f0717c0858854d7d7dc72::chkm {
    struct CHKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHKM>(arg0, 6, b"CHKM", b"CHEEKY MOLE", b"Digging deep into the meme market, Cheeky Mole is unearthing treasure for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_041851814_13b6ad8734.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

