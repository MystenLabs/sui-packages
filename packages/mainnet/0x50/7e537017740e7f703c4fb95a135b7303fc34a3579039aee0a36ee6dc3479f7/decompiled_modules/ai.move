module 0x507e537017740e7f703c4fb95a135b7303fc34a3579039aee0a36ee6dc3479f7::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1ac7e629aac604df43883a65116cea91a3abf61352be19486e485e48a615e45c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AI          ")))), trim_right(b"Alpha Intelligence              "), trim_right(x"416c70686120496e74656c6c6967656e63652069732074686520776f726c642773206d6f737420616476616e63656420766f6963652041492c20646563656e7472616c697a65642e0a0a4561726e20536f6c616e612072657761726473206576657279203135206d696e75746573206a75737420627920686f6c64696e67210a0a546f6b656e6f6d6963733a0a0a3725207461780a353525206f6620726576656e756520646973747269627574656420746f20686f6c6465727320696e2024534f4c0a34302520616c6c6f636174656420746f7761726473206d61726b6574696e6720746f6b656e0a3525206275726e656420666f72206465666c6174696f6e0a0a203230323520416c70686120496e74656c6c6967656e63652e20416c6c207269676874732072657365727665642e20202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

