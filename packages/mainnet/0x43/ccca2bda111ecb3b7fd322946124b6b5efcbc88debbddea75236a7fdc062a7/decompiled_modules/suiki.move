module 0x43ccca2bda111ecb3b7fd322946124b6b5efcbc88debbddea75236a7fdc062a7::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 6, b"SUIKI", b"SUIKI DOGS", x"245355494b490a0a446f6773207769746820746865206e616d652053756b69206172652062656c696576656420746f20626567656e746c6520796574207370697269746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiki_1c4cc767f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

