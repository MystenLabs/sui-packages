module 0x8359a55e715fd9cef18be587c2f959920ef8196c1349bead506223380062eef3::bast {
    struct BAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAST>(arg0, 6, b"BAST", b"Baby Stingray", b"Gliding effortlessly through the waters of  sui - watch out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_230635_db30c0a913.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

