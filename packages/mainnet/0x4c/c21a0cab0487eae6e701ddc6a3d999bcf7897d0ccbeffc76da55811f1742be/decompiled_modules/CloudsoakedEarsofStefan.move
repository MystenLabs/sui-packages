module 0x4cc21a0cab0487eae6e701ddc6a3d999bcf7897d0ccbeffc76da55811f1742be::CloudsoakedEarsofStefan {
    struct CLOUDSOAKEDEARSOFSTEFAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDSOAKEDEARSOFSTEFAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDSOAKEDEARSOFSTEFAN>(arg0, 0, b"COS", b"Cloudsoaked Ears of Stefan", b"When you return, you will hear only adventure... the unknown call...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Cloudsoaked_Ears_of_Stefan.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOUDSOAKEDEARSOFSTEFAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDSOAKEDEARSOFSTEFAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

