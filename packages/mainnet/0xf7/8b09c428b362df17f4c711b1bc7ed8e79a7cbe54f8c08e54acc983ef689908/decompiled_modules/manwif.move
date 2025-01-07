module 0xf78b09c428b362df17f4c711b1bc7ed8e79a7cbe54f8c08e54acc983ef689908::manwif {
    struct MANWIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANWIF>, arg1: 0x2::coin::Coin<MANWIF>) {
        0x2::coin::burn<MANWIF>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANWIF>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 9 / 100;
        let v1 = arg2 - v0;
        let v2 = v1 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<MANWIF>>(0x2::coin::mint<MANWIF>(arg0, v1 - v2, arg3), arg1);
        0x2::coin::burn<MANWIF>(arg0, 0x2::coin::mint<MANWIF>(arg0, v2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<MANWIF>>(0x2::coin::mint<MANWIF>(arg0, v2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<MANWIF>>(0x2::coin::mint<MANWIF>(arg0, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: MANWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANWIF>(arg0, 9, b"MANWIF", b"ManWif", x"4d616e5769662069732074686520756c74696d617465206d656d6520636f696e207468617420756e69746573207061777320616e6420636c61777320696e207468652077696c6420776f726c64206f662063727970746f2e205468697320746f6b656e20697320706f77657265642062792074686520656e65726779206f662074776f2062656c6f76656420696e7465726e6574206661766f7269746573e28094706c617966756c207075707320616e64206d697363686965766f7573206b697474696573e28094636f6d696e6720746f67657468657220746f206272696e6720796f7520646f75626c65207468652066756e20616e6420646f75626c6520746865206761696e732e205768657468657220796f75277265207465616d20446f67206f72207465616d204361742c207468657265277320726f6f6d20666f722065766572796f6e6520696e207468697320636f6d6d756e6974792e20484f444c2074696768742c2062656361757365207768656e20646f677320616e642063617473206a6f696e20666f726365732c207468657265e2809973206e6f206c696d697420746f207768657265207468697320636f696e2063616e20676fe28094737472616967687420746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1792571582902095872/1h0Tm7RU_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANWIF>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANWIF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

