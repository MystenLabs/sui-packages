module 0x48a09cfcd14cf6ba8576bd0b4f013d8c7b528846833817c9f0de15af3cbe7ade::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 9, b"BACON", b"DogeBacon", x"746865206f6e6c79206d656d6520636f696e2074686174e28099732031303025206261726b2d74617374696320616e6420323030252064656c6963696f7573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BACON>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

