module 0xca3be5da8a518748867a5419018bddd69b70da09e9c0a0d87d2744b8b1b20b9d::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 9, b"wagmi", b"wagmi", b"we are gonna make it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.graphassets.com/resize=w:2666,h:1776,fit:crop/auto_image/compress/XU6gX86tRKHTkVCCpfjY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAGMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

