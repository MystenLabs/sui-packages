module 0x352ceba3ad58ac550c28352757a7bff506c0a77b7cf4222acbf55b7a2a3fb439::nms {
    struct NMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMS>(arg0, 6, b"NMS", b"NemoFish", b"NemoFish is a community meme on the Sui Network, featuring an effective deflationary mechanism. The goal of NemoFish is to become the top meme on the Sui Network.Website: https://www.nemosui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.nemosui.com/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NMS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

