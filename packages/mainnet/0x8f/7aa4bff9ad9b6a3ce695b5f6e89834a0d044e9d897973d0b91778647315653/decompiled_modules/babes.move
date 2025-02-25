module 0x8f7aa4bff9ad9b6a3ce695b5f6e89834a0d044e9d897973d0b91778647315653::babes {
    struct BABES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABES>(arg0, 6, b"BaBes", b"Babescoin.xo", x"224261626573222063c3b3206e6869e1bb817520c3bd206e6768c4a961200a0a43c3a163682067e1bb8d69207468c3a26e206de1baad743a0a0a44c3b96e6720c491e1bb832067e1bb8d69206e67c6b0e1bb9d692079c3aa752c2062e1baa16e207468c3a26e20686fe1bab76320616920c491c3b32064e1bb85207468c6b0c6a16e672e0a0a56c3ad2064e1bba53a20224865792c20626162652120486f772077617320796f7572206461793f2220284ec3a07920656d2079c3aa75212048c3b46d206e6179207468e1babf206ec3a06f3f292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c43a3358-86c3-4df0-82af-af0bef0a227d.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

