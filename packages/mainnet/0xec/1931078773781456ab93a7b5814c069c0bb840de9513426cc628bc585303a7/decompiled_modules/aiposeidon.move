module 0xec1931078773781456ab93a7b5814c069c0bb840de9513426cc628bc585303a7::aiposeidon {
    struct AIPOSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPOSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPOSEIDON>(arg0, 6, b"AIPoseidon", b"Poseidon AI", x"506f736569646f6e2022476f64206f662074686520536561222041490a746865207469646573206f6620746865206469676974616c207265616c6d2065626220616e6420666c6f772c2072657665616c696e672068696464656e2074726561737572657320666f722074686f73652077686f206461726520746f20646976652062656e65617468207468652073757266616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734600725376.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPOSEIDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPOSEIDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

