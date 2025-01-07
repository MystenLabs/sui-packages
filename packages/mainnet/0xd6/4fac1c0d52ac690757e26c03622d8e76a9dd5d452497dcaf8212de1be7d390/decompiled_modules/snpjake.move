module 0xd64fac1c0d52ac690757e26c03622d8e76a9dd5d452497dcaf8212de1be7d390::snpjake {
    struct SNPJAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNPJAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNPJAKE>(arg0, 6, b"SNPJAKE", b"SnoopJake", x"536e6f6f704a616b65202824534e504a414b45292069732074686520756c74696d61746520667573696f6e206f662066756e2c2063756c747572652c20616e64207374796c652e20496e73706972656420627920746865206c6567656e64617279206368617269736d61206f66206d656d657320616e6420746865206c6169642d6261636b2076696265206f6620676c6f62616c2069636f6e732c2074686973206d656d65636f696e206973206d6f7265207468616e206a7573742063727970746f63757272656e63793a206974e28099732061206d6f76656d656e742e20576974682024534e504a414b452c207765206c617567682c2067726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732059282720.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNPJAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNPJAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

