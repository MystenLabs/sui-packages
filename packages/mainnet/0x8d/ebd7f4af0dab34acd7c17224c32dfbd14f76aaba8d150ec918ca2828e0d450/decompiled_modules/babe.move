module 0x8debd7f4af0dab34acd7c17224c32dfbd14f76aaba8d150ec918ca2828e0d450::babe {
    struct BABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABE>(arg0, 6, b"BaBe", b"Babescoin", x"312e2043c3a163682067e1bb8d69207468c3a26e206de1baad743a0a0a44c3b96e6720c491e1bb832067e1bb8d69206e67c6b0e1bb9d692079c3aa752c2062e1baa16e207468c3a26e20686fe1bab76320616920c491c3b32064e1bb85207468c6b0c6a16e672e0a0a20224865792c20626162652120486f772077617320796f7572206461793f2220284ec3a07920656d2079c3aa75212048c3b46d206e6179207468e1babf206ec3a06f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c21faa5e-c120-4ecb-a311-d22a09a035ac.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

