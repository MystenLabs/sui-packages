module 0xd761f1b2b8c690389a90b20a52c50f32774e442998ff91025ae40d8495f35b2::suiscriber {
    struct SUISCRIBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCRIBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCRIBER>(arg0, 9, b"SUISCRIBER", b"SUISCRIBER", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sp-ao.shortpixel.ai/client/to_webp,q_lossy,ret_img,w_250,h_250/https://www.hypebot.com/wp-content/uploads/2022/07/youtube-250x250.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISCRIBER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCRIBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISCRIBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

