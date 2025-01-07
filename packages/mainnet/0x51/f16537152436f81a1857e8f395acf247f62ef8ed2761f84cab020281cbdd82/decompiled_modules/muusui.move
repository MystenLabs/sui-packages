module 0x51f16537152436f81a1857e8f395acf247f62ef8ed2761f84cab020281cbdd82::muusui {
    struct MUUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUUSUI>(arg0, 6, b"MUUSUI", b"MUU on SUI", x"5468652043757465737420436174204f6e2054696b746f6b205769746820313937204d696c6c696f6e206c696b65732e0a244d757520416c736f20486f6c647320546865204f6666696369616c2054696b746f6b20417761726420466f7220546865204265737420416e696d616c20436f6e74656e742043726561746f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Dljf_QXW_400x400_130824e2cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

