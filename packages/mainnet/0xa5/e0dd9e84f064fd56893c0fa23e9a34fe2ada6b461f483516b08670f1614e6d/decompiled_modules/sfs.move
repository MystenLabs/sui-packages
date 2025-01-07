module 0xa5e0dd9e84f064fd56893c0fa23e9a34fe2ada6b461f483516b08670f1614e6d::sfs {
    struct SFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFS>(arg0, 6, b"SFS", b"Smoking Fish Sui", x"536d6f6b696e6720466973682069732061206e6577205374617220576172732d7468656d6564206d656d65636f696e206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/69855db74e0fd14f45a4acd7f8103d57_443da4d8ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

