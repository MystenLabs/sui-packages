module 0x4a88933b5177acd80824eac21335d01ffb5a874450391da4688d68d97887108a::cbdc {
    struct CBDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CBDC>(arg0, 9, b"-Crypto Bee Digital Candy-(CBDC)", b"CBDC", b"CBDC is a Crypto full of FUN! From AR to VR, we want to capture your imagination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https:&#x2F;&#x2F;pbs.twimg.com&#x2F;media&#x2F;GZty34dWsAMBa1P?format&#x3D;png&amp;name&#x3D;small")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CBDC>(&mut v3, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CBDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBDC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBDC>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CBDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CBDC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

