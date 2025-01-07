module 0x12a275793bb9ac5ba209357e825753bd726ef3ae648937e00b6ff52956857898::acedog {
    struct ACEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACEDOG>(arg0, 6, b"ACEDOG", b"Ace dog on SUI", x"24414345207761732072756767656420616e64206162616e646f6e656420627920746865206f776e6572206f6e200a405355492e0a57652077696c6c207265736375652074686973206375746520646f6720616e642074616b6520697420746f2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_H1_Z_Uc_OX_400x400_0a12a781cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

