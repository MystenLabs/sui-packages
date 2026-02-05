module 0x4633a9668e3fb7921632d926edc763f3239e452a86b412200fd26a5e0457e9a0::tehuibotai {
    struct TEHUIBOTAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEHUIBOTAI>, arg1: 0x2::coin::Coin<TEHUIBOTAI>) {
        0x2::coin::burn<TEHUIBOTAI>(arg0, arg1);
    }

    fun init(arg0: TEHUIBOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEHUIBOTAI>(arg0, 6, b"Tehuibotplus", b"TehuibotAI", x"5472e1bba3206cc3ad2041492063e1bba76120546568756920e280942067e1bb8d6e2067c3a06e672c207468e1bab36e67207468e1baaf6e3b2068e1bb97207472e1bba3206e68e1baaf63207669e1bb87632c207468e1bb9d69207469e1babf742c2074696e2074e1bba9632c2076c3a0206175746f6d6174696f6e2074726f6e67204f70656e436c61772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVhDqF.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEHUIBOTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEHUIBOTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEHUIBOTAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEHUIBOTAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

