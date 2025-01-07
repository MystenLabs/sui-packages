module 0xe3336b4bd568080e8962f7758ac9c84dffa0fd380f56cc0213ed1f310027279a::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLO>(arg0, 6, b"CARLO", b"CARLO ON SUI", x"4361726c6f206973206120636c696e6963616c6c7920696e73616e6520646f67207769746820612070696e6b20612a2a686f6c652e20596f75206265742e204275742074686174732077686174206d616b65732068696d2061206c6567656e6420617420666c697070696e672070726f666974732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u246_H9_HN_400x400_3797960a11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

