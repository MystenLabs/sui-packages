module 0x608a78a678008b3057fe394f3c36c9c19bc74eab667f9353a17bcb2f50f829::hanabi {
    struct HANABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANABI>(arg0, 6, b"Hanabi", b"Hanabi-chan", x"4e6569726f2773206e657720667269656e642048616e616269210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J8ko_Yvydd_H_Gnjw4_W5_Xk1vn_Zxm_Kdt_Ue_V_Jup7ghhz_Vpump_6c16b16d27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

