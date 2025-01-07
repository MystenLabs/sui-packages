module 0x26d2b346995a107c7740ee00acd129fe236a513d4acbbc6e076661a549ef02ec::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"Suilion", x"41726520796f75206775797320726561647920666f7220245355494c494f4e3f0a0a476f6f64204172742c20476f6f6420416e696d6174696f6e2c20446f78786564205465616d2c20537570706f72742066726f6d20535549204f47732c20426173656420646576732c20616e64206d6f72652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037349_1cd4031653.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}

