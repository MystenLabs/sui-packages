module 0xaee92e958b520ae0dc8878906579040d412d076fef2d289b15d83be5846c4744::WoollyM3GOHat {
    struct WOOLLYM3GOHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLLYM3GOHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLLYM3GOHAT>(arg0, 0, b"COS", b"Woolly M3GO Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Woolly_M3GO_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOLLYM3GOHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLLYM3GOHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

