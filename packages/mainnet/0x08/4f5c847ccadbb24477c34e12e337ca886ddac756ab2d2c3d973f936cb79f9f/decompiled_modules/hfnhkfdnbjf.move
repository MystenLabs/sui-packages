module 0x84f5c847ccadbb24477c34e12e337ca886ddac756ab2d2c3d973f936cb79f9f::hfnhkfdnbjf {
    struct HFNHKFDNBJF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFNHKFDNBJF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFNHKFDNBJF>(arg0, 6, b"HFNHKFDNBJF", b"sgnsugrnurng", b"adfnunvwrnv wjrnvownrvunwvunroifjwiurubgwurngownrgunrrgn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_2_upscayl_4x_ultrasharp_71fc6aedea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFNHKFDNBJF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFNHKFDNBJF>>(v1);
    }

    // decompiled from Move bytecode v6
}

