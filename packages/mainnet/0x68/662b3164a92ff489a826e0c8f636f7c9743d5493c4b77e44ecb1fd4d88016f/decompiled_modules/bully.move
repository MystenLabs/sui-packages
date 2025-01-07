module 0x68662b3164a92ff489a826e0c8f636f7c9743d5493c4b77e44ecb1fd4d88016f::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"Bully", b"Sui Bully", b"Bully was no ordinary bull. Strong, smart, and determined, he roamed the vast plains with a keen sense of purpose. Unlike the others, who charged without thinking, Bully carefully navigated challenges, always looking for opportunities to grow. His calm confidence earned him the respect of all, making him a leader among the herd. Wherever Bully went, others followed, trusting his vision and strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_VQX_Jc8f_400x400_1_a2af4bc916.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

