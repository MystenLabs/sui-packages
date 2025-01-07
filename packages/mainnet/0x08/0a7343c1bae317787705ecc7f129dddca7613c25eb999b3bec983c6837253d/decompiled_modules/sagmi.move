module 0x80a7343c1bae317787705ecc7f129dddca7613c25eb999b3bec983c6837253d::sagmi {
    struct SAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGMI>(arg0, 6, b"SAGMI", b"Sagmi sui", x"247361676d690a53554920414c4c20474f494e4720544f204d414b45204954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040049_b958603d02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

