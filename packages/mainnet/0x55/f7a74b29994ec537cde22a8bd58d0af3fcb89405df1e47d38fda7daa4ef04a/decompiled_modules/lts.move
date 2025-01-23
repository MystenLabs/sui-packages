module 0x55f7a74b29994ec537cde22a8bd58d0af3fcb89405df1e47d38fda7daa4ef04a::lts {
    struct LTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTS>(arg0, 6, b"LTS", b"L Token 2", b"LTS to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/d3a2b330-d949-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTS>>(v1);
        0x2::coin::mint_and_transfer<LTS>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

