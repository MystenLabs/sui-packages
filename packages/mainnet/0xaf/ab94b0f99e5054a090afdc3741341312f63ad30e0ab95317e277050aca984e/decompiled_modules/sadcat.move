module 0xafab94b0f99e5054a090afdc3741341312f63ad30e0ab95317e277050aca984e::sadcat {
    struct SADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCAT>(arg0, 6, b"SADCAT", b"Sad Cat", b"Why sad ? Pringles good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatars_p0gx745cmzh_P64p6_xuiwlg_t1080x1080_6d73a5af2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

