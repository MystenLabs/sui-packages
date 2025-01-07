module 0x7f8581d66a3ce4bb977af4b89d1e2463f2c906d62752ecc1c460ff908437cc1c::spooky {
    struct SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKY>(arg0, 6, b"SPOOKY", b"Spooky Sui", x"47657420726561647920666f722053706f6f6b79205375692c206120746f6b656e2074686174206f6666657273206368696c6c7320616e64206578636974656d656e74207768696c652073686f776572696e6720796f7520776974682073706f6f6b792073757270726973657320617420657665727920747769737421202020202020202020202020202020202020202020202020202020202020202020202020202020200a486170707920484f444c206f7220536361726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPOOKY_LOGO_eff9feb84b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

