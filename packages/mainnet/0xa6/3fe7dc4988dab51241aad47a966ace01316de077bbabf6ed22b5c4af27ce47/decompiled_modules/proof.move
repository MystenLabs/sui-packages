module 0xa63fe7dc4988dab51241aad47a966ace01316de077bbabf6ed22b5c4af27ce47::proof {
    struct PROOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROOF>(arg0, 6, b"Proof", b"Sui is Cool", x"43544f20746869732e200a50726f76652074686174207468652053554920636f6d6d756e69747920697320636f6f6c2e20446576206f6e6c7920686f6c647320322520616e642077696c6c206e657665722064756d702e204465762072657665616c2061742031204d696c69696f6e204d430a57652063616e205375696969696969696969696969696969696969696969696969696969696969696969696969", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdk_image_6a987a67a4_0x223759397_ED_62960222_AF_946a_F833993220835d9_c4b13a_30946663a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

