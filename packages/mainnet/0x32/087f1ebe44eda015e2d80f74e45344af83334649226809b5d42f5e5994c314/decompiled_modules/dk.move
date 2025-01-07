module 0x32087f1ebe44eda015e2d80f74e45344af83334649226809b5d42f5e5994c314::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 6, b"DK", b"DEGEN KIDS SUI", x"4173206b6964732c2074686579206c6f737420746865697220706172656e747320746f0a41726970617061277320736861646f77732e204e6f772c20617320736b696c6c65640a726562656c732c207468657927766520756e636f766572656420736563726574730a746f206469736d616e746c652068697320656d706972652e20417269706170610a72756c65732c20627574206f757220646563656e7472616c697a65642041490a726562656c6c696f6e2066696768747320666f722066726565646f6d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul9_20241214164322_1f3a464818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DK>>(v1);
    }

    // decompiled from Move bytecode v6
}

